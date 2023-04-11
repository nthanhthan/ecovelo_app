import 'package:flutter/material.dart';

class AppKeys {
  static const languageKey = "language-key";
  static const themModeKey = "theme-key";
  static const voiceMode = "voice-mode";
}

class AppColors {
  static const MaterialColor main = MaterialColor(0xff3C5041, {
    100: Color(0xffCCEBDA),
    200: Color(0xff1E4C2F),
    300: Color(0xff3C5041),
    400: Color(0xffF0F9F4),
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
  static const MaterialColor secondary = MaterialColor(0xffFC8838, {
    100: Color(0xffFDEAD9),
    200: Color(0xffF9CB9F),
    300: Color(0xffFC8838),
  });
  static const MaterialColor grey = MaterialColor(0xff1F1F1F, {
    100: Color(0xffD9D9D9),
    200: Color(0xffBFBFBF),
    300: Color(0xff8C8C8C),
    400: Color(0xff1F1F1F),
    500: Color(0xffF3F3F3),
  });
  static const MaterialColor warning = MaterialColor(0xffB2223A, {
    100: Color(0xffFBECEE),
    200: Color(0xffEC9EAB),
    300: Color(0xffDE5067),
    400: Color(0xffB2223A),
  });
  static const MaterialColor success = MaterialColor(0xff499D2F, {
    100: Color(0xffF2FBEF),
    200: Color(0xffB0E3A1),
    300: Color(0xff75CE5A),
    400: Color(0xff499D2F),
  });
  static const defaultBackgroundImageColor = Color(0xffF1ECFB);
  static const defaultTextColor = Color(0xff000000);
  static const disableTextColor = Color(0xff2C303E);
  static const black = Color(0xff000000);
  static const white = Color(0xffFFFFFF);
  static const disableButtonBackground = Color(0xffD9D9D9);
  static const defaultBackground = Color(0xffFFFFFF);
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
  static const String fontFamilyName = "Poppins";
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
