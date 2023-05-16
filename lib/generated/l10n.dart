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

  /// `Continue`
  String get continueBtn {
    return Intl.message(
      'Continue',
      name: 'continueBtn',
      desc: '',
      args: [],
    );
  }

  /// `Distances `
  String get distances {
    return Intl.message(
      'Distances ',
      name: 'distances',
      desc: '',
      args: [],
    );
  }

  /// `{nums}+`
  String numDistances(Object nums) {
    return Intl.message(
      '$nums+',
      name: 'numDistances',
      desc: '',
      args: [nums],
    );
  }

  /// `This week points`
  String get titleWeekPoint {
    return Intl.message(
      'This week points',
      name: 'titleWeekPoint',
      desc: '',
      args: [],
    );
  }

  /// `Keep participating in weekly chanllenges and earn rewards.`
  String get desWeekPoint {
    return Intl.message(
      'Keep participating in weekly chanllenges and earn rewards.',
      name: 'desWeekPoint',
      desc: '',
      args: [],
    );
  }

  /// `Total distances`
  String get totalDistances {
    return Intl.message(
      'Total distances',
      name: 'totalDistances',
      desc: '',
      args: [],
    );
  }

  /// `Total time`
  String get totalTime {
    return Intl.message(
      'Total time',
      name: 'totalTime',
      desc: '',
      args: [],
    );
  }

  /// `Carbon Reduced`
  String get carbon {
    return Intl.message(
      'Carbon Reduced',
      name: 'carbon',
      desc: '',
      args: [],
    );
  }

  /// `Energy`
  String get energy {
    return Intl.message(
      'Energy',
      name: 'energy',
      desc: '',
      args: [],
    );
  }

  /// `Recent Activities`
  String get recentActivities {
    return Intl.message(
      'Recent Activities',
      name: 'recentActivities',
      desc: '',
      args: [],
    );
  }

  /// `View details`
  String get detail {
    return Intl.message(
      'View details',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Journey Details`
  String get journeyDetail {
    return Intl.message(
      'Journey Details',
      name: 'journeyDetail',
      desc: '',
      args: [],
    );
  }

  /// `Share journey`
  String get shareJourney {
    return Intl.message(
      'Share journey',
      name: 'shareJourney',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get titleTime {
    return Intl.message(
      'Time',
      name: 'titleTime',
      desc: '',
      args: [],
    );
  }

  /// `Journey Code`
  String get titleJourneyCode {
    return Intl.message(
      'Journey Code',
      name: 'titleJourneyCode',
      desc: '',
      args: [],
    );
  }

  /// `Payment Type`
  String get titlePayment {
    return Intl.message(
      'Payment Type',
      name: 'titlePayment',
      desc: '',
      args: [],
    );
  }

  /// `Report Problem`
  String get reportProblem {
    return Intl.message(
      'Report Problem',
      name: 'reportProblem',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitBtn {
    return Intl.message(
      'Submit',
      name: 'submitBtn',
      desc: '',
      args: [],
    );
  }

  /// `Bike Number`
  String get bikeNumber {
    return Intl.message(
      'Bike Number',
      name: 'bikeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Select Problem`
  String get selectProblem {
    return Intl.message(
      'Select Problem',
      name: 'selectProblem',
      desc: '',
      args: [],
    );
  }

  /// `Can't unlock`
  String get unlock {
    return Intl.message(
      'Can\'t unlock',
      name: 'unlock',
      desc: '',
      args: [],
    );
  }

  /// `QR error`
  String get qrError {
    return Intl.message(
      'QR error',
      name: 'qrError',
      desc: '',
      args: [],
    );
  }

  /// `Lock broken`
  String get lockBroken {
    return Intl.message(
      'Lock broken',
      name: 'lockBroken',
      desc: '',
      args: [],
    );
  }

  /// `Bike vandalized`
  String get bikeVandalized {
    return Intl.message(
      'Bike vandalized',
      name: 'bikeVandalized',
      desc: '',
      args: [],
    );
  }

  /// `Can't buy more point`
  String get notBuyMorePoint {
    return Intl.message(
      'Can\'t buy more point',
      name: 'notBuyMorePoint',
      desc: '',
      args: [],
    );
  }

  /// `Can't finish ride`
  String get notFinishRide {
    return Intl.message(
      'Can\'t finish ride',
      name: 'notFinishRide',
      desc: '',
      args: [],
    );
  }

  /// `Flat tire`
  String get flatTire {
    return Intl.message(
      'Flat tire',
      name: 'flatTire',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image or Video`
  String get uploadImage {
    return Intl.message(
      'Upload Image or Video',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get titleDes {
    return Intl.message(
      'Description',
      name: 'titleDes',
      desc: '',
      args: [],
    );
  }

  /// `Enter desciption...`
  String get hintDes {
    return Intl.message(
      'Enter desciption...',
      name: 'hintDes',
      desc: '',
      args: [],
    );
  }

  /// `Desciption must be shorter than or equal to 255 characters`
  String get notesMustShorterThan {
    return Intl.message(
      'Desciption must be shorter than or equal to 255 characters',
      name: 'notesMustShorterThan',
      desc: '',
      args: [],
    );
  }

  /// `Enter Money Amount`
  String get enterMoney {
    return Intl.message(
      'Enter Money Amount',
      name: 'enterMoney',
      desc: '',
      args: [],
    );
  }

  /// `Select Source`
  String get selectSource {
    return Intl.message(
      'Select Source',
      name: 'selectSource',
      desc: '',
      args: [],
    );
  }

  /// `Unable to access storage!`
  String get unableToAccessStorage {
    return Intl.message(
      'Unable to access storage!',
      name: 'unableToAccessStorage',
      desc: '',
      args: [],
    );
  }

  /// `Storage access denied. Let open the app setting to enable it!`
  String get storageAccessDenied {
    return Intl.message(
      'Storage access denied. Let open the app setting to enable it!',
      name: 'storageAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `Pick file using?`
  String get pickeFileUsing {
    return Intl.message(
      'Pick file using?',
      name: 'pickeFileUsing',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Choose file from Directory`
  String get chooseFromFileDirectory {
    return Intl.message(
      'Choose file from Directory',
      name: 'chooseFromFileDirectory',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get takePhoto {
    return Intl.message(
      'Take Photo',
      name: 'takePhoto',
      desc: '',
      args: [],
    );
  }

  /// `File already exists!`
  String get fileAlreadyExists {
    return Intl.message(
      'File already exists!',
      name: 'fileAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Upload Another`
  String get uploadAnother {
    return Intl.message(
      'Upload Another',
      name: 'uploadAnother',
      desc: '',
      args: [],
    );
  }

  /// `File upload must be smaller than 10 Mb`
  String get fileTooLarge {
    return Intl.message(
      'File upload must be smaller than 10 Mb',
      name: 'fileTooLarge',
      desc: '',
      args: [],
    );
  }

  /// `Upload File`
  String get uploadFile {
    return Intl.message(
      'Upload File',
      name: 'uploadFile',
      desc: '',
      args: [],
    );
  }

  /// `Have been an account.`
  String get haveAccount {
    return Intl.message(
      'Have been an account.',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter the password again`
  String get passWordAgain {
    return Intl.message(
      'Enter the password again',
      name: 'passWordAgain',
      desc: '',
      args: [],
    );
  }

  /// `Go!`
  String get goStation {
    return Intl.message(
      'Go!',
      name: 'goStation',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get ready {
    return Intl.message(
      'Ready',
      name: 'ready',
      desc: '',
      args: [],
    );
  }

  /// `No available bikes`
  String get noBike {
    return Intl.message(
      'No available bikes',
      name: 'noBike',
      desc: '',
      args: [],
    );
  }

  /// `Your Address`
  String get yourAddress {
    return Intl.message(
      'Your Address',
      name: 'yourAddress',
      desc: '',
      args: [],
    );
  }

  /// `ECO - Station {number} `
  String stationNumber(Object number) {
    return Intl.message(
      'ECO - Station $number ',
      name: 'stationNumber',
      desc: '',
      args: [number],
    );
  }

  /// `Password don't match`
  String get noMatchPass {
    return Intl.message(
      'Password don\'t match',
      name: 'noMatchPass',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your pass`
  String get enterPass {
    return Intl.message(
      'Please enter your pass',
      name: 'enterPass',
      desc: '',
      args: [],
    );
  }

  /// `Password match`
  String get correct {
    return Intl.message(
      'Password match',
      name: 'correct',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noResultFound {
    return Intl.message(
      'No results found',
      name: 'noResultFound',
      desc: '',
      args: [],
    );
  }

  /// `Search for EcoVelo stations`
  String get lableSearch {
    return Intl.message(
      'Search for EcoVelo stations',
      name: 'lableSearch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter mobile number`
  String get enterPhone {
    return Intl.message(
      'Please enter mobile number',
      name: 'enterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid mobile number`
  String get validatePhone {
    return Intl.message(
      'Please enter valid mobile number',
      name: 'validatePhone',
      desc: '',
      args: [],
    );
  }

  /// `Your phone number or password is incorrect.`
  String get erEmailOrPasswordInvalid {
    return Intl.message(
      'Your phone number or password is incorrect.',
      name: 'erEmailOrPasswordInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Successful registration, login to continue.`
  String get signupsucess {
    return Intl.message(
      'Successful registration, login to continue.',
      name: 'signupsucess',
      desc: '',
      args: [],
    );
  }

  /// `QR Code is incorrect, please try again`
  String get errorQR {
    return Intl.message(
      'QR Code is incorrect, please try again',
      name: 'errorQR',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle is in use, please change to another vehicle`
  String get bicycleRented {
    return Intl.message(
      'Vehicle is in use, please change to another vehicle',
      name: 'bicycleRented',
      desc: '',
      args: [],
    );
  }

  /// `Minimum score is 5000, please recharge`
  String get score {
    return Intl.message(
      'Minimum score is 5000, please recharge',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `Return vehicle with problem, please try again`
  String get stopRentError {
    return Intl.message(
      'Return vehicle with problem, please try again',
      name: 'stopRentError',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to end your trip?`
  String get messageConfirmEnd {
    return Intl.message(
      'Are you want to end your trip?',
      name: 'messageConfirmEnd',
      desc: '',
      args: [],
    );
  }

  /// `You must do the your bike lock first`
  String get lockFirst {
    return Intl.message(
      'You must do the your bike lock first',
      name: 'lockFirst',
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
