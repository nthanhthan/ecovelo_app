import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  final RxInt _currentTab = 0.obs;
  set currentTab(int value) => _currentTab.value = value;
  int get currentTab => _currentTab.value;
  final PageStorageBucket bucket = PageStorageBucket();
  late LoginManager _loginManager;

  UserModel? userModel;

  List<Widget> screen = [
    const HomeScreen(),
    const MapView(),
    const NotificationView(),
    const SettingView(),
  ];

  Widget currentScreen = const HomeScreen();

  final RxnBool _isCloseBottomModel = RxnBool();
  set isCloseBottomModel(bool? value) => _isCloseBottomModel.value = value;
  bool? get isCloseBottomModel => _isCloseBottomModel.value;

  String bikeID = "";
  late DateTime startTime;
  late Timer timer;

  final RxInt _elapsedTimeInSeconds = 0.obs;
  set elapsedTimeInSeconds(int value) => _elapsedTimeInSeconds.value = value;
  int get elapsedTimeInSeconds => _elapsedTimeInSeconds.value;

  late final RentHttpService _rentHttpService;
  late final AuthHttpService _authHttpService;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    isLoading = false;
    WidgetsBinding.instance.addObserver(this);
    _loginManager = Get.find<LoginManager>();
    _rentHttpService = Get.find<RentHttpService>();
    _authHttpService = Get.find<AuthHttpService>();
    getUser().then((value) {
      if (value) {
        isLoading = true;
      }
    });
    String bicycleID = Prefs.getString(AppKeys.bicycleIDRent);
    if (bicycleID.isNotEmpty) {
      bikeID = bicycleID;
      getRent();
    }
    if (Get.arguments != null && Get.arguments is String) {
      bikeID = Get.arguments as String;
      Prefs.saveString(AppKeys.bicycleIDRent, bikeID);
      getRent();
    }
    super.onInit();
  }

  Future<bool> getUser() async {
    final result = await _authHttpService.getUser();
    if (result.isSuccess() && result.data != null) {
      _loginManager.saveUser(result.data);
    }
    userModel = _loginManager.getUser();
    return true;
  }

  void getRent() {
    String bicycleid = Prefs.getString(AppKeys.bicycleIDRent);
    MQTTClientWrapper newclient = MQTTClientWrapper();
    newclient.prepareMqttClient(bicycleid);
    String beginTimer = Prefs.getString(AppKeys.beginRent);
    if (beginTimer.isNotEmpty) {
      startTime = DateTime.parse(beginTimer);
    } else {
      startTime = DateTime.now();
    }
    beginRent();
  }

  @override
  void onReady() {
    if (bikeID.isNotEmpty) {
      const HomeScreen().showBottomSheetRentBicycle(Get.context!);
    }
    super.onReady();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void beginRent() {
    Prefs.saveString(AppKeys.beginRent, startTime.toString());
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      elapsedTimeInSeconds = DateTime.now().difference(startTime).inSeconds;
    });
  }

  String caculateTimer() {
    bool isOverOneHour = elapsedTimeInSeconds >= 3600;
    String elapsedTimeText = isOverOneHour
        ? '${(elapsedTimeInSeconds / 3600).floor()}:${((elapsedTimeInSeconds / 60) % 60).floor().toString().padLeft(2, '0')}:${(elapsedTimeInSeconds % 60).toString().padLeft(2, '0')}'
        : '${(elapsedTimeInSeconds / 60).floor()}:${(elapsedTimeInSeconds % 60).toString().padLeft(2, '0')}';
    return elapsedTimeText;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      LogUtil.d('Home: on app ressume!');
    }
  }

  Widget getWidget() {
    return screen[currentTab];
  }

  void updateCloseBottomModel(bool value) {
    isCloseBottomModel = value;
  }

  bool checkCloseBottomModel() {
    if (isCloseBottomModel != null) {
      return isCloseBottomModel!;
    } else {
      return false;
    }
  }

  void stopRentBicycle() {
    // ProcessingDialog processingDialog = ProcessingDialog.show();
    // int rentID = Prefs.getInt(AppKeys.rentID);
    // final result = await _rentHttpService.stopRentBicycle(bikeID, rentID);
    // if (result.isSuccess() && result.data != null) {
    //   processingDialog.hide();
    //   _loginManager.saveUser(result.data);
    //   Prefs.removeKey(AppKeys.bicycleIDRent);
    //   Prefs.removeKey(AppKeys.beginRent);
    //   Prefs.removeKey(AppKeys.rentID);
    //   return true;
    // }
    // processingDialog.hide();
    // return false;
    Get.dialog<void>(
      ConfirmDialog(
        message: S.of(Get.context!).lockFirst,
        isHideCancelButton: true,
        approveText: S.of(Get.context!).ok,
      ),
    );
  }
}
