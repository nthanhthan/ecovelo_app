// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `ECOVELO`
  String get appName {
    return Intl.message(
      'ECOVELO',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processing {
    return Intl.message(
      'Processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Locate Stations Nearby`
  String get onBoarding1Title {
    return Intl.message(
      'Locate Stations Nearby',
      name: 'onBoarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Ride and Explore`
  String get onBoarding2Title {
    return Intl.message(
      'Ride and Explore',
      name: 'onBoarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Personalized recommendations based on your interactions`
  String get onBoarding3Title {
    return Intl.message(
      'Personalized recommendations based on your interactions',
      name: 'onBoarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Quickly find a bike rental station near you to start your ride.`
  String get onBoardingPage1Description {
    return Intl.message(
      'Quickly find a bike rental station near you to start your ride.',
      name: 'onBoardingPage1Description',
      desc: '',
      args: [],
    );
  }

  /// `Explore the city on our reliable and comfortable bikes, and have fun along the way.`
  String get onBoardingPage2Description {
    return Intl.message(
      'Explore the city on our reliable and comfortable bikes, and have fun along the way.',
      name: 'onBoardingPage2Description',
      desc: '',
      args: [],
    );
  }

  /// `Our app learns from your interactions to provide personalized recommendations and suggestions that suit your specific needs and preferences`
  String get onBoardingPage3Description {
    return Intl.message(
      'Our app learns from your interactions to provide personalized recommendations and suggestions that suit your specific needs and preferences',
      name: 'onBoardingPage3Description',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address in format: yourname@example.com`
  String get invalidEmailAddress {
    return Intl.message(
      'Please enter your email address in format: yourname@example.com',
      name: 'invalidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `At least eight characters`
  String get invalidPasswordLength {
    return Intl.message(
      'At least eight characters',
      name: 'invalidPasswordLength',
      desc: '',
      args: [],
    );
  }

  /// `At least one letter`
  String get invalidPasswordOneLetter {
    return Intl.message(
      'At least one letter',
      name: 'invalidPasswordOneLetter',
      desc: '',
      args: [],
    );
  }

  /// `At least one special letter`
  String get invalidPasswordOneSpecialLetter {
    return Intl.message(
      'At least one special letter',
      name: 'invalidPasswordOneSpecialLetter',
      desc: '',
      args: [],
    );
  }

  /// `At least one number`
  String get invalidPasswordOneNumber {
    return Intl.message(
      'At least one number',
      name: 'invalidPasswordOneNumber',
      desc: '',
      args: [],
    );
  }

  /// `At least one capital letter`
  String get invalidPasswordOneCapitalLetter {
    return Intl.message(
      'At least one capital letter',
      name: 'invalidPasswordOneCapitalLetter',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Chnage Password`
  String get changePass {
    return Intl.message(
      'Chnage Password',
      name: 'changePass',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notifi {
    return Intl.message(
      'Notification',
      name: 'notifi',
      desc: '',
      args: [],
    );
  }

  /// `Deactive Account`
  String get deactiveAcc {
    return Intl.message(
      'Deactive Account',
      name: 'deactiveAcc',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get helpCenter {
    return Intl.message(
      'Help Center',
      name: 'helpCenter',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `VietNamese`
  String get vietnamese {
    return Intl.message(
      'VietNamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `Have a nice day!`
  String get niceDay {
    return Intl.message(
      'Have a nice day!',
      name: 'niceDay',
      desc: '',
      args: [],
    );
  }

  /// `Hi {name},`
  String hi(Object name) {
    return Intl.message(
      'Hi $name,',
      name: 'hi',
      desc: '',
      args: [name],
    );
  }

  /// `Scan to Ride`
  String get scanToRide {
    return Intl.message(
      'Scan to Ride',
      name: 'scanToRide',
      desc: '',
      args: [],
    );
  }

  /// `Unable to access camera!`
  String get unableToAccessCamera {
    return Intl.message(
      'Unable to access camera!',
      name: 'unableToAccessCamera',
      desc: '',
      args: [],
    );
  }

  /// `Camera access denied. Let open the app setting to enable it!`
  String get cameraAccessDenied {
    return Intl.message(
      'Camera access denied. Let open the app setting to enable it!',
      name: 'cameraAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `This app needs camera access to scan QR codes`
  String get noCameraPermissionDesctiption {
    return Intl.message(
      'This app needs camera access to scan QR codes',
      name: 'noCameraPermissionDesctiption',
      desc: '',
      args: [],
    );
  }

  /// `Let's enjoy a stress-free ride during peak hours and `
  String get textBanner {
    return Intl.message(
      'Let\'s enjoy a stress-free ride during peak hours and ',
      name: 'textBanner',
      desc: '',
      args: [],
    );
  }

  /// `get 10% off.`
  String get discout {
    return Intl.message(
      'get 10% off.',
      name: 'discout',
      desc: '',
      args: [],
    );
  }

  /// `Main Wallet`
  String get mainWallet {
    return Intl.message(
      'Main Wallet',
      name: 'mainWallet',
      desc: '',
      args: [],
    );
  }

  /// `Promo Wallet`
  String get promoWallet {
    return Intl.message(
      'Promo Wallet',
      name: 'promoWallet',
      desc: '',
      args: [],
    );
  }

  /// `Eco velo`
  String get ecoitem {
    return Intl.message(
      'Eco velo',
      name: 'ecoitem',
      desc: '',
      args: [],
    );
  }

  /// `Add money`
  String get addMoney {
    return Intl.message(
      'Add money',
      name: 'addMoney',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get myWallet {
    return Intl.message(
      'My Wallet',
      name: 'myWallet',
      desc: '',
      args: [],
    );
  }

  /// `My journey`
  String get myJourney {
    return Intl.message(
      'My journey',
      name: 'myJourney',
      desc: '',
      args: [],
    );
  }

  /// `Eco Voucher`
  String get ecoVoucher {
    return Intl.message(
      'Eco Voucher',
      name: 'ecoVoucher',
      desc: '',
      args: [],
    );
  }

  /// `Ready to Ride`
  String get readyRide {
    return Intl.message(
      'Ready to Ride',
      name: 'readyRide',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Type`
  String get ticketType {
    return Intl.message(
      'Ticket Type',
      name: 'ticketType',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discoutText {
    return Intl.message(
      'Discount',
      name: 'discoutText',
      desc: '',
      args: [],
    );
  }

  /// `One-time Ticket`
  String get oneTimeTicket {
    return Intl.message(
      'One-time Ticket',
      name: 'oneTimeTicket',
      desc: '',
      args: [],
    );
  }

  /// `Select Voucher`
  String get selectVoucher {
    return Intl.message(
      'Select Voucher',
      name: 'selectVoucher',
      desc: '',
      args: [],
    );
  }

  /// `Introduction`
  String get introduction {
    return Intl.message(
      'Introduction',
      name: 'introduction',
      desc: '',
      args: [],
    );
  }

  /// `Need Help ?`
  String get needHelp {
    return Intl.message(
      'Need Help ?',
      name: 'needHelp',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to start!`
  String get proceed {
    return Intl.message(
      'Proceed to start!',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  /// `Get  more time`
  String get getMoreTime {
    return Intl.message(
      'Get  more time',
      name: 'getMoreTime',
      desc: '',
      args: [],
    );
  }

  /// `Finish ride`
  String get finishRide {
    return Intl.message(
      'Finish ride',
      name: 'finishRide',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
