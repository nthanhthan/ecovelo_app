import '../../core.dart';
part 'app_routes.dart';

class AppPages {
  static const intilial = Routes.main;
  static final routes = [
    GetPage<dynamic>(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.zoom,
    ),
    GetPage<dynamic>(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.onBoarding,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.signin,
      page: () => const SignInView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.language,
      page: () => const LanguageView(),
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.scanQR,
      page: () => const ScanView(),
      binding: ScanBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.rentBicycle,
      page: () => const RentBicycleView(),
      binding: RentBicycleBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.journey,
      page: () => const JourneyView(),
      binding: JourneyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.journeyDetail,
      page: () => const JourneyDetailView(),
      binding: JourneyDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.reportProblem,
      page: () => const ReportProblemView(),
      binding: ReportProblemBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.addMoney,
      page: () => const AddMoneyView(),
      binding: AddMoneyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.transferSuccess,
      page: () => const TransferSuccessView(),
      binding: TransferSuccessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.feedback,
      page: () => const FeedBackView(),
      binding: FeedbackBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.stationBike,
      page: () => const MapView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.transactionHistory,
      page: () => const HistoryView(),
      binding: HistoryBingding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.enterCode,
      page: () => const KeyBoardCode(),
      binding: EnterCodeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.verifiAccount,
      page: () => const VerifiAccountView(),
      binding: VerifiAccountBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.nearStation,
      page: () => const StationNearView(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.ecoUser,
      page: () => const EcoUserView(),
      binding: EcoUseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      binding:EcoUseDetailBinding(),
      name: Routes.ecoUserDetail,
      page: () => const EcoUserDetail(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.changeRole,
      page: () => const ChangeRoleView(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.authencationView,
      page: () => const AuthencationView(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.fixProblem,
      page: () => const FixProblemView(),
      binding: FixProblemBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.fixProblemDetail,
      page: () => const FixProblemDetail(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.ecoStation,
      page: () => const EcoStationView(),
      binding: EcoStationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.revenueView,
      page: () => const RevenueView(),
      binding: RevenueBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.newStation,
      page: () => const NewStationView(),
      binding: NewStationBinding(),
      transition: Transition.rightToLeft,
    ),
      GetPage<dynamic>(
      name: Routes.mapStation,
      page: () => const MapViewStaton(),
      transition: Transition.rightToLeft,
    ),
  ];
}
