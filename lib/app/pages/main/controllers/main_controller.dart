import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();

  late LoginManager _loginManager;
  late final SessionManager _sessionM;
  late ConfigPackacgeService configService;

  LoginResp? loginResp;
  AuthHttpService? authHttpService;
  @override
  void onInit() {
    _loginManager = Get.find<LoginManager>();
    authHttpService = Get.find<AuthHttpService>();
    configService = ConfigPackacgeService(
      configAndroid: "config_notification",
      configIOS: "config_notification",
    );
    configService.initializeConfigRemote().then((value) {
      appInitializer();
    });

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

    _sessionM = Get.find<SessionManager>();

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
    await _loginManager.initSession();

    //Set Language
    String lang = Prefs.getString(AppKeys.languageKey, defaultValue: "en_US");
    await MyApp.of(Get.context!)?.changeLanguage(lang);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    loginResp = _loginManager.getLogin();
    try {
      final data = configService.getRemoteConfig();
      final result =
          NotificationConfig.fromJson(jsonDecode(data) as Map<String, dynamic>);
      if (result.isEnable != null && result.isEnable == true) {
        NotificationService().cancelNotificationAll().then((value) {
          NotificationService().scheduledNotification(
            id: 2,
            title: "EcoVelo",
            body: result.message ?? "",
            hour: result.hour??16,
            minute: result.minutes??30,
          );
        });
      } else {
        await NotificationService().cancelNotificationAll();
      }
      // ignore: empty_catches
    } catch (e) {}

    //Delay for show Splash screen
    await Future.delayed(const Duration(seconds: 2), () {
      checkFistLaunch();
    });
  }

  Future<void> checkFistLaunch() async {
    if (loginResp != null) {
      bool isAuthenticated = await _isAuthenticated();
      if (isAuthenticated) {
        final result = await authHttpService!.getUser();
        if (result.isSuccess() && result.data != null) {
          _loginManager.saveUser(result.data);
        }
        Get.offNamed(Routes.home);
      } else {
        Get.offNamed(Routes.signin);
      }
    } else {
      bool isNotFirstLaunch = Prefs.getBool(AppKeys.firstLaunch);
      if (isNotFirstLaunch) {
        Get.offNamed<void>(Routes.onBoarding);
        //Get.offNamed(Routes.signin);
      } else {
        await Prefs.saveBool(AppKeys.firstLaunch, true);
        Get.offNamed<void>(Routes.onBoarding);
      }
    }
  }

  Future<bool> _isAuthenticated() async {
    bool checkSession = await _sessionM.hasSession();
    if (checkSession) {
      await _sessionM.initSession(_sessionM.session!);
      return true;
    } else {
      return false;
    }
  }
}
