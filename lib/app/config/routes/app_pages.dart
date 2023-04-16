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
      binding: JourneyBinding(),
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
  ];
}
