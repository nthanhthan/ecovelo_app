import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
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
}
