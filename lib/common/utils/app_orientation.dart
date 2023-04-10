import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOrientation {
  static Future<void> setPreferredOrientationLandscape() async {
    DeviceOrientation deviceOrientation;
    Platform.isAndroid ? deviceOrientation = DeviceOrientation.landscapeLeft : deviceOrientation = DeviceOrientation.landscapeRight;
    await SystemChrome.setPreferredOrientations([deviceOrientation]);
  }

  static Future<void> setPreferredOrientationPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static Future<void> setAllPreferredOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static Future<void> setFullScreenApp() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  static Future<void> setFullScreenEnableSystemUIApp({
    Brightness brightness = Brightness.light,
    Color statusBarColor = Colors.white,
  }) async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: brightness,
      statusBarColor: statusBarColor,
      systemNavigationBarColor: statusBarColor,
    ));
  }
}
