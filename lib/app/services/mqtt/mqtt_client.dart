import 'dart:io';
import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MqttCurrentConnectionState {
  idle,
  connecting,
  conneted,
  disconect,
  error,
}

enum MqttSubscriptionState { idle, subscribed }

Future<bool> enTripClick(MqttServerClient client) async {
  final RentHttpService _rentHttpService = Get.find<RentHttpService>();
  final LoginManager _loginManager = Get.find<LoginManager>();
  ProcessingDialog processingDialog = ProcessingDialog.show();
  int rentID = Prefs.getInt(AppKeys.rentID);
  String bicycleID = Prefs.getString(AppKeys.bicycleIDRent);
  final result = await _rentHttpService.stopRentBicycle(bicycleID, rentID);
  if (result.isSuccess() && result.data != null) {
    client.disconnect();
    processingDialog.hide();
    _loginManager.saveUser(result.data);
    Prefs.removeKey(AppKeys.bicycleIDRent);
    Prefs.removeKey(AppKeys.beginRent);
    Prefs.removeKey(AppKeys.rentID);
    return true;
  }
  processingDialog.hide();
  return false;
}

class MQTTClientWrapper {
  late MqttServerClient client;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.idle;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.idle;

  // using async tasks, so the connection won't hinder the code flow
  void prepareMqttClient(String bicycleID) async {
    _setupMqttClient();
    await _connectClient();
    _subscribeToTopic(bicycleID);
    //_publishMessage('Hello');
  }

  // waiting for the connection, if an error occurs, print it and disconnect
  Future<void> _connectClient() async {
    try {
      LogUtil.d('client connecting....');
      connectionState = MqttCurrentConnectionState.connecting;
      await client.connect('ecovelo', '0901948483');
    } on Exception catch (e) {
      LogUtil.d('client exception - $e');
      connectionState = MqttCurrentConnectionState.error;
      client.disconnect();
    }

    // when connected, print a confirmation, else print an error
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.conneted;
      LogUtil.d('client connected');
    } else {
      LogUtil.d(
          'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.error;
      client.disconnect();
    }
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(
        '9dff104817e54495b402e7a024636147.s2.eu.hivemq.cloud',
        "ecovelo_app",
        8883);
    // the next 2 lines are necessary to connect with tls, which is used by HiveMQ Cloud
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  void _subscribeToTopic(String topicName) {
    LogUtil.d('Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    // print the message when it is received
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      LogUtil.d('YOU GOT A NEW MESSAGE:');
      LogUtil.d(message);
      if (message == "2") {
        confirmStopRent(Get.context!);
      }
    });
  }

  void confirmStopRent(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          S.of(context).messageConfirmEnd,
                          style: AppTextStyles.body1().copyWith(
                            color: AppColors.main.shade200,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: () {
                            enTripClick(client).then((value) {
                              if (value == true) {
                                Get.offAllNamed(Routes.feedback);
                              } else {
                                ToastMessage.error(
                                    message: S.of(Get.context!).stopRentError);
                              }
                            });
                          },
                          style: OutlineButtonStyle.enable(isFullWidth: true),
                          child: Text(
                            S.of(context).confirm,
                            style: AppTextStyles.body2().copyWith(
                              color: AppColors.main.shade200,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                left: 110,
                child: Transform.translate(
                  offset: const Offset(0, -60),
                  child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.main,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // callbacks for different events
  void _onSubscribed(String topic) {
    LogUtil.d('Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.subscribed;
  }

  // void _onDisconnected() {
  //   LogUtil.d('OnDisconnected client callback - Client disconnection');
  //   connectionState = MqttCurrentConnectionState.disconect;
  // }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.conneted;
    LogUtil.d('OnConnected client callback - Client connection was sucessful');
  }
}
