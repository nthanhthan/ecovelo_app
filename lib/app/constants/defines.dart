import 'package:flutter/material.dart';

class AppKeys {
  static const languageKey = "language-key";
  static const themModeKey = "theme-key";
  static const voiceMode = "voice-mode";
}

class AppColors {
  static const MaterialColor main = MaterialColor(0xff0F6EFA, {
    100: Color(0xffEDF2FA),
    200: Color(0xffADC5E7),
    300: Color(0xff5B8ACE),
    400: Color(0xff0F6EFA),
  });
  static const MaterialColor red = MaterialColor(0xffEA3656, {
    100: Color(0xffFFEDF0),
    200: Color(0xffFBD7DD),
    300: Color(0xffF9C3CC),
    400: Color(0xffF7AFBB),
    500: Color(0xffF2869A),
    600: Color(0xffEE5E78),
    700: Color(0xffEA3656),
  });
  static const MaterialColor secondary = MaterialColor(0xff825A24, {
    100: Color(0xffFDEFDB),
    200: Color(0xffF6B863),
    300: Color(0xffE58B0E),
    400: Color(0xff825A24),
  });
  static const MaterialColor grey = MaterialColor(0xff4A5054, {
    100: Color(0xffFFFFFF),
    200: Color(0xffCCCAD0),
    300: Color(0xff3E4356),
    400: Color(0xff313544),
    500: Color(0xff222222),
    600: Color(0xff4A5054),
  });
  static const warningColor = Color(0xffED3E3E);
  static const successColor = Color(0xff39D72B);
  static const defaultBackgroundImageColor = Color(0xffF1ECFB);
  static const defaultTextColor = Color(0xffCCCAD0);
  static const disableTextColor = Color(0xff2C303E);
  static const black = Color(0xff000000);
  static const white = Color(0xffFFFFFF);
  static const disableButtonBackground = Color(0xff313544);
  static const defaultBackground = Color(0xff13171C);
  static const darkScrollbarColor = Color(0xffC7B2EF);
  static const iconColor = Color(0xFF0F6EFA);
  static const hideContent = Color(0xFF4A5054);
  static const colorAppBar = Color(0xFF11141A);
  static const lightBlue = Color(0xFF78C3CD);
  static const lightPink = Color(0xFFE58FA7);
  static const lightPurple = Color(0xFF7E7DD1);
  static const popupColor = Color(0xff313544);
  static const colorChoosePlan = Color(0xff2C303E);
}

class AppProperties {
  //animation time duration
  static const String fontFamilyName = "Inter";
  static const int navTransitionDuration = 400; //milisecond
  static const int defaultTransitionDuration = 400; //milisecond
  static const Duration defaultAnimatedDuration = Duration(milliseconds: 350);
  static const double contentMargin = 12;
  static const double inputHight = 62;
  static const double circleRadius = 8;
  static const double dialogCircleRadius = 10;
  static const double lineSpace = 8;
  static const double cardElevation = .5;
  static const double buttonElevation = 1;
  static const double navigationBarElevation = 2;
  static const double popupElevation = 2;
  static const double itemSpace = 12;
  static const double bottomSheetRadius = 20;
  static const EdgeInsetsGeometry defaultButtonPadding =
      EdgeInsets.only(top: 12, bottom: 12, left: 32, right: 32);
  static const EdgeInsetsGeometry defaultSmallButtonPadding =
      EdgeInsets.only(top: 6, bottom: 6, left: 24, right: 24);
  static const EdgeInsetsGeometry defaultMediumButtonPadding =
      EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16);

  static const double iconButtonSizeDef = 24;
  static const double appBarHeight = 72;
}

enum AppThemeMode {
  dark,
  light,
}

const maxTextScaleFactorDef = 1.26;
