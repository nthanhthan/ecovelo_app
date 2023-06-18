import 'dart:io';
import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MqttCurrentConnectionState {
  idle,
  connecting,
  conneted,
  disconnect,
  error,
}

enum MqttSubscriptionState { idle, subscribed }

class MQTTClientWrapper {
  static final MQTTClientWrapper _instance = MQTTClientWrapper._internal();
  factory MQTTClientWrapper() {
    return _instance;
  }
  MQTTClientWrapper._internal();
  late MqttServerClient client;
  late List<StationModel> listStation;
  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.idle;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.idle;
  final MapController _mapController = Get.put<MapController>(MapController());

  // using async tasks, so the connection won't hinder the code flow
  void prepareMqttClient(String bicycleID) async {
    _setupMqttClient();
    await connectClient();
    _subscribeToTopic(bicycleID);
    //_publishMessage('Hello');
  }

  void checkConnected(String bicycleID) {
    if (connectionState != MqttCurrentConnectionState.conneted &&
        connectionState != MqttCurrentConnectionState.connecting) {
      prepareMqttClient(bicycleID);
    }
  }

  // waiting for the connection, if an error occurs, print it and disconnect
  Future<void> connectClient() async {
    try {
      if (connectionState != MqttCurrentConnectionState.conneted &&
          connectionState != MqttCurrentConnectionState.connecting) {
        LogUtil.d('client connecting....');
        connectionState = MqttCurrentConnectionState.connecting;
        await client.connect('ecovelo', '0901948483');
      }
    } on Exception catch (e) {
      LogUtil.d('client exception - $e');
      connectionState = MqttCurrentConnectionState.error;
      //client.disconnect();
    }

    // when connected, print a confirmation, else print an error
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.conneted;
      LogUtil.d('client connected');
    } else {
      LogUtil.d(
          'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.error;
      // client.disconnect();
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
    client.keepAlivePeriod = 1200;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
    client.onDisconnected = _onDisconnected;
    client.autoReconnect = true;
    client.onAutoReconnected = _onAutoReconnected;
  }

  void _onAutoReconnected() {
    LogUtil.d('Auto Reconected');
    connectionState = MqttCurrentConnectionState.conneted;
  }

  Future<void> _subscribeToTopic(String topicName) async {
    LogUtil.d('Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    listStation = await _mapController.getListStation();
    // print the message when it is received
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      LogUtil.d('YOU GOT A NEW MESSAGE:');
      LogUtil.d(message);
      if (message == "2") {
        if (listStation.isNotEmpty) {
          double? stationDistance = checkPositonUserNearStation();
          if (stationDistance != null && stationDistance != -1) {
            if (stationDistance >= 0 && stationDistance < 10) {
              confirmStopRent(
                Get.context!,
                S.of(Get.context!).messageConfirmEnd,
                confirmEndtrip,
              );
            } else {
              connectClient();
              confirmStopRent(Get.context!, S.of(Get.context!).temoraryLock,
                  () {
                confirmtTemoraryLock(topicName);
              });
            }
          } else {
            confirmStopRent(
              Get.context!,
              S.of(Get.context!).endTripError,
              endTripError,
            );
          }
        }
      }
      if (message == "fall") {
        fallBicyle();
      }
    });
  }

  double? checkPositonUserNearStation() {
    _mapController.getMyPositionCurrent();
    Position? myPositon = _mapController.position;
    if (myPositon != null) {
      listStation.sort(
        (a, b) {
          double distanceToA = Geolocator.distanceBetween(
              myPositon.latitude, myPositon.longitude, a.lat ?? 0, a.lng ?? 0);
          double distanceToB = Geolocator.distanceBetween(
              myPositon.latitude, myPositon.longitude, b.lat ?? 0, b.lng ?? 0);
          a.distance = distanceToA.toString();
          b.distance = distanceToB.toString();
          return distanceToA.compareTo(distanceToB);
        },
      );
    }
    return double.tryParse(listStation.first.distance ?? "-1");
  }

  void confirmStopRent(
    BuildContext context,
    String message,
    Function? handle,
  ) {
    showDialog<void>(
      context: context,
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
                          message,
                          style: AppTextStyles.body1().copyWith(
                            color: AppColors.main.shade200,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: () {
                            if (handle != null) {
                              handle.call();
                            } else {
                              Navigator.of(context).pop();
                            }
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

  void _onDisconnected() {
    LogUtil.d('OnDisconnected client callback - Client disconnection');
    if (connectionState == MqttCurrentConnectionState.conneted) {
      connectionState = MqttCurrentConnectionState.disconnect;
    }
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.conneted;
    LogUtil.d('OnConnected client callback - Client connection was sucessful');
  }

  Future<StopResponse?> enTripClick(MqttServerClient client) async {
    final RentHttpService _rentHttpService = Get.find<RentHttpService>();
    ProcessingDialog processingDialog = ProcessingDialog.show();
    int rentID = Prefs.getInt(AppKeys.rentID);
    String bicycleID = Prefs.getString(AppKeys.bicycleIDRent);
    if (listStation.first.id != null) {
      final result = await _rentHttpService.stopRentBicycle(
          bicycleID, rentID, listStation.first.id!);
      if (result.isSuccess() && result.data != null) {
        client.disconnect();
        processingDialog.hide();
        StopResponse? stopResponse = result.data;
        Prefs.removeKey(AppKeys.bicycleIDRent);
        Prefs.removeKey(AppKeys.beginRent);
        Prefs.removeKey(AppKeys.rentID);
        Prefs.removeKey(AppKeys.lockTemporary);
        Prefs.removeKey(AppKeys.fallBicycle);
        return stopResponse;
      }
    }
    processingDialog.hide();
    return null;
  }

  void confirmEndtrip() {
    enTripClick(client).then((value) {
      if (value != null) {
        Get.offAllNamed(
          Routes.feedback,
          arguments: value,
        );
      } else {
        ToastMessage.error(message: S.of(Get.context!).stopRentError);
      }
    });
  }

  void confirmtTemoraryLock(String topicName) {
    checkConnected(topicName);
    if (connectionState == MqttCurrentConnectionState.conneted) {
      final builder = MqttClientPayloadBuilder();
      builder.addString('3');
      if (builder.payload != null) {
        client.publishMessage(topicName, MqttQos.atLeastOnce, builder.payload!);
        Prefs.saveBool(AppKeys.lockTemporary, true);
        Navigator.of(Get.context!).pop();
        Get.offAllNamed(Routes.home);
      } else {
        confirmStopRent(
          Get.context!,
          S.of(Get.context!).temoraryLockError,
          endTripError,
        );
      }
    } else {
      SnackBars.complete(message: "Try again");
    }
  }

  void endTripError() {
    Navigator.of(Get.context!).pop();
  }

  void showOpenLock(String topicName) {
    confirmStopRent(Get.context!, S.of(Get.context!).openLockContinue, () {
      confirmOpenLock(topicName);
    });
  }

  void confirmOpenLock(String topicName) {
    if (connectionState == MqttCurrentConnectionState.conneted) {
      final builder = MqttClientPayloadBuilder();
      builder.addString('0');
      if (builder.payload != null) {
        client.publishMessage(topicName, MqttQos.atLeastOnce, builder.payload!);
        Prefs.removeKey(AppKeys.lockTemporary);
        Navigator.of(Get.context!).pop();
        client.disconnect();
        prepareMqttClient(topicName);
        Get.offAllNamed(Routes.home);
      }
    } else {
      SnackBars.complete(message: "Try again");
    }
  }

  Future<void> fallBicyle() async {
    bool isFall = false;
    if (Prefs.getString(AppKeys.fallBicycle).isNotEmpty) {
      String beforeTime = Prefs.getString(AppKeys.fallBicycle);
      int checkTime = DateTime.now()
          .difference(DateFormat("yyyy-MM-dd HH:mm:ss").parse(beforeTime))
          .inSeconds;
      if (checkTime >= 60) {
        confirmStopRent(
          Get.context!,
          S.of(Get.context!).fallBicycle,
          null,
        );
        Prefs.saveString(AppKeys.fallBicycle, DateTime.now().toString());
        isFall = true;
      }
    } else {
      Prefs.saveString(AppKeys.fallBicycle, DateTime.now().toString());
      confirmStopRent(
        Get.context!,
        S.of(Get.context!).fallBicycle,
        null,
      );
      isFall = true;
    }
    if (isFall) {
      final RentHttpService _rentHttpService = Get.find<RentHttpService>();
      int rentID = Prefs.getInt(AppKeys.rentID);
      final result = await _rentHttpService.fallBicyle(rentID);
      if (result.isSuccess()) {}
    }
  }
}
