import 'dart:async';

import 'package:flutter/services.dart';

import '../../../core.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  @override
  void onInit() {
   appInitializer();
    super.onInit();
  }

  @override
  void onClose() async {
    await HiveManager.close();
    super.onClose();
  }

  Future<void> appInitializer() async {
    await Prefs.load();
    DioClient.clearInterceptors(DioClient.currentDio());

    // DioClient.setInterceptorRetry(DioClient.currentDio());
    if (BuildConfig().isDebug) {
      DioClient.setInterceptorLogger(
        DioClient.currentDio(),
        printOnSuccess: true,
      );
    }

    //client service
    DioClient.onErrorHandle = AppApiError.errorMessageHandle;
    DioClient.updateBaseUrl(
      DioClient.currentDio(),
      Uri.parse(BuildConfig().env.baseApi),
    );
    DioClient.updateTimeOut(
      DioClient.currentDio(),
      connectTimeOut: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );
    //Init Hive
    await HiveManager.init();
    //Set Language
    String lang = Prefs.getString(AppKeys.languageKey, defaultValue: "en_US");
    await MyApp.of(Get.context!)?.changeLanguage(lang);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    //Delay for show Splash screen
    await Future.delayed(const Duration(seconds: 2), () {

      Get.offNamed<void>(Routes.onBoarding);
    });
  }
}
