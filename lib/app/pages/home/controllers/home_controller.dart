import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  final RxInt _currentTab = 0.obs;
  set currentTab(int value) => _currentTab.value = value;
  int get currentTab => _currentTab.value;
  final PageStorageBucket bucket = PageStorageBucket();

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

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);

    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
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
}
