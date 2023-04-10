import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }

  static _MyApp? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyApp>();
}

class _MyApp extends State<MyApp> {
  late Locale _locale;
  late ThemeData _themeData;

  @override
  void initState() {
    super.initState();
    //init location
    _locale = Locale(Platform.localeName);
    //init theme data
    _themeData = lightTheme;
    //init build config
    BuildConfig().setupEnviroment();
    //Devlopment mode config
    LogUtil.init(isDebug: BuildConfig().isDebug, tag: "Ecovelo");
    DioClient.setDebugMode(BuildConfig().isDebug);

    //Storage load
    Prefs.load().then((value) {
      //Dev testing
      loadSavedEnviroment();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppOrientation.setPreferredOrientationPortrait();
   // RateAppHelper().initMyApp(context);
    return DismissKeyboard(
      child: GetMaterialApp(
        title: "Ecovelo",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        navigatorObservers: [
          LocalNotificationObserver(),
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: _locale,
        theme: _themeData,
        themeMode: ThemeMode.light,
        //darkTheme: darkTheme,
        defaultTransition: Transition.cupertino,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        transitionDuration:
            const Duration(milliseconds: AppProperties.navTransitionDuration),
        initialBinding: MainBinding(),
        initialRoute: AppPages.intilial,
        getPages: AppPages.routes,
      ),
    );
  }

  Future<void> changeLanguage(String langCode) async {
    await Prefs.saveString(AppKeys.languageKey, langCode);
    String lang = '';
    String? country;
    String symboySpec = '';
    langCode.contains('_') ? symboySpec = '_' : '-';

    lang = langCode.split(symboySpec).first;
    if (langCode.contains(symboySpec)) {
      country = langCode.split(symboySpec).last;
    }
    Locale locale = Locale(lang, country);
    await S.load(locale);
    await Future.delayed(const Duration(milliseconds: 300), () => null);
    setState(() {
      _locale = locale;
    });
  }

  Future<void> changeTheme(AppThemeMode theme) async {
    await Prefs.saveString(AppKeys.themModeKey, theme.toString());
    setState(() {
      switch (theme) {
        case AppThemeMode.dark:
          _themeData = lightTheme;
          break;
        case AppThemeMode.light:
          _themeData = darkTheme;
          break;
      }
    });
  }
}
