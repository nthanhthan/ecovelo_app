import 'package:flutter/material.dart';
import '../../core.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: const MaterialColor(
    4285677272,
    {
      50: Color(0xfff0eafb),
      100: Color(0xffe0d5f6),
      200: Color(0xffc1aaee),
      300: Color(0xffa280e5),
      400: Color(0xff8355dd),
      500: Color(0xff642bd4),
      600: Color(0xff5022aa),
      700: Color(0xff3c1a7f),
      800: Color(0xff281155),
      900: Color(0xff14092a)
    },
  ),
  fontFamily: AppProperties.fontFamilyName,
  brightness: Brightness.light,
  primaryColor: const Color(0xff0F6EFA),
  primaryColorLight: const Color(0xffe0d5f6),
  primaryColorDark: const Color(0xff3c1a7f),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff11141a),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: Color(0xffE6E1E5),
      fontSize: 24,
    ),
    centerTitle: true,
    elevation: 0,
    actionsIconTheme: IconThemeData(color: Color(0xff000000)),
    iconTheme: IconThemeData(color: Color(0xff6D6F7E)),
    toolbarHeight: 72,
  ),
  canvasColor: const Color(0xfffafafa),
  scaffoldBackgroundColor: const Color(0xff13171C),
  bottomAppBarColor: const Color(0xffffffff),
  cardColor: const Color(0xffffffff),
  cardTheme: const CardTheme(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
  ),
  dividerColor: const Color(0xffCBCCD6),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  selectedRowColor: const Color(0xfff5f5f5),
  unselectedWidgetColor: const Color(0x8a000000),
  disabledColor: const Color(0x61000000),
  toggleableActiveColor: const Color(0xff723ED8),
  secondaryHeaderColor: const Color(0xffe9f2fc),
  backgroundColor: const Color(0xffc6d4c4),
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: const Color(0xff0F6EFA),
  hintColor: const Color(0x8a000000),
  errorColor: const Color(0xffEE5E78),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        const BorderSide(
          color: AppColors.main,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      textStyle: MaterialStateProperty.all(
        AppTextStyles.button().copyWith(color: AppColors.grey)
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      padding: MaterialStateProperty.all(
          AppProperties.defaultButtonPadding
      ),
      overlayColor: MaterialStateProperty.all(AppColors.main[100]),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(.5),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.main.shade300; // Disabled color
        }
        return AppColors.main; // Regular color
      }),
      textStyle: MaterialStateProperty.all(AppTextStyles.button()),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      padding: MaterialStateProperty.all(
          AppProperties.defaultButtonPadding
      ),
      foregroundColor: MaterialStateProperty.all(AppColors.white),
      overlayColor: MaterialStateProperty.all(AppColors.main[300]),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
          AppTextStyles.textButton()
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      padding: MaterialStateProperty.all(
          AppProperties.defaultButtonPadding
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88,
    height: 36,
    padding: AppProperties.defaultButtonPadding,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: AppColors.main,
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    alignedDropdown: false,
    buttonColor: Color(0xffe0e0e0),
    disabledColor: Color(0xffAAAAAA),
    highlightColor: Color(0x2906192d),
    splashColor: Color(0x1f06192d),
    focusColor: Color(0x1f06192d),
    hoverColor: Color(0x0a06192d),
    colorScheme: ColorScheme(
      primary: Color(0xff723ed8),
      primaryContainer: Color(0xff3c1a7f),
      secondary: Color(0xff642bd4),
      secondaryContainer: Color(0xff3c1a7f),
      surface: Color(0xffffffff),
      background: Color(0xffc1aaee),
      error: Color(0xffFF8888),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xffffffff),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: Color(0xffffffff),
      fontSize: 38,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      color: Color(0xffffffff),
      fontSize: 30,
      fontWeight: FontWeight.w600,
    ),
    headline3: TextStyle(
      color: Color(0xff343434),
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    headline4: TextStyle(
      color: Color(0xff343434),
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    headline5: TextStyle(
      color: Color(0xff343434),
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    headline6: TextStyle(
      color: Color(0xff343434),
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: Color(0xff723ed8),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline3: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline4: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline5: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline6: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xff343434),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color(0xff6F6F6F),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color(0xff4A5054),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color(0xffEE5E78),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    contentPadding: EdgeInsets.only(top: 14, bottom: 14, left: 16, right: 10),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: true,
    fillColor: Color(0xff313544),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffEE5E78),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffEE5E78),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
    ),
  ),
  //end input
  iconTheme: const IconThemeData(
    color: Color(0xff723ED8),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  sliderTheme: const SliderThemeData(
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
    labelPadding: EdgeInsets.zero
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color(0x1f06192d),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde06192d),
    disabledColor: Color(0x0c06192d),
    labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
    labelStyle: TextStyle(
      color: Color(0xde06192d),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d06192d),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0xff3c1a7f),
    selectedColor: Color(0x3d06192d),
    shape: StadiumBorder(
        side: BorderSide(
      color: Color(0xff723ED8),
      width: 0,
      style: BorderStyle.none,
    )),
  ),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
    side: BorderSide(
      color: Color(0xff723ED8),
      width: 0,
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  )),
);
