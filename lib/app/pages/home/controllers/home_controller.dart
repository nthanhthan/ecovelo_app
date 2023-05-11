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

  LoginResp? loginResp;

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

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    _loginManager = Get.find<LoginManager>();
    _rentHttpService = Get.find<RentHttpService>();
    loginResp = _loginManager.getUser();
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

  void getRent() {
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

  void updateCloseBottomModel() {
    isCloseBottomModel ??= true;
  }

  bool checkCloseBottomModel() {
    if (isCloseBottomModel != null) {
      return isCloseBottomModel!;
    } else {
      return false;
    }
  }

  Future<bool> stopRentBicycle() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    int rentID = Prefs.getInt(AppKeys.rentID);
    final result = await _rentHttpService.stopRentBicycle(bikeID, rentID);
    if (result.isSuccess() && result.data != null) {
      processingDialog.hide();
      if (result.data == -1) {
        return false;
      }
      Prefs.removeKey(AppKeys.bicycleIDRent);
      Prefs.removeKey(AppKeys.beginRent);
      Prefs.removeKey(AppKeys.rentID);
      return true;
    }

    processingDialog.hide();
    return false;
  }
}
