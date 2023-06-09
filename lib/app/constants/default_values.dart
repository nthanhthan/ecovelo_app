import 'package:ecoveloapp/app/core.dart';

class DefaultValues {
  static List<MoneyModel> addMoneyValues = [
    MoneyModel(id: 0, money: 20000),
    MoneyModel(id: 1, money: 30000),
    MoneyModel(id: 2, money: 50000),
    MoneyModel(id: 3, money: 70000),
    MoneyModel(id: 4, money: 100000),
    MoneyModel(id: 5, money: 200000),
  ];
  static List<BankModel> bankList = [
    BankModel(
      id: 0,
      nameBank: "Stripe",
      desBank: "Ngân hàng TMCP Kỹ thương Việt Nam",
      logo: AssetsConst.stripeIc,
    ),
    BankModel(
      id: 1,
      nameBank: "Techcombank (TCB)",
      desBank: "Ngân hàng TMCP Kỹ thương Việt Nam",
      logo: AssetsConst.techcombank,
    ),
    BankModel(
      id: 2,
      nameBank: "Vietinbank (CTG)",
      desBank: "Ngân hàng TMCP Công thương Việt Nam",
      logo: AssetsConst.vietinbank,
    ),
    BankModel(
      id: 3,
      nameBank: "Momo",
      desBank: "Link Momo Wallet",
      logo: AssetsConst.momo,
    ),
  ];
  static const List<Map<String, String>> paymentMethodList = [
    {"title": "Add New Card", "asset": AssetsConst.addRectangle},
  ];

  static List<ProblemModel> listProblems = [
    ProblemModel(id: 0, name: S.of(Get.context!).unlock),
    ProblemModel(id: 1, name: S.of(Get.context!).qrError),
    ProblemModel(id: 2, name: S.of(Get.context!).lockBroken),
    ProblemModel(id: 3, name: S.of(Get.context!).bikeVandalized),
    ProblemModel(id: 4, name: S.of(Get.context!).notBuyMorePoint),
    ProblemModel(id: 5, name: S.of(Get.context!).flatTire),
    ProblemModel(id: 6, name: S.of(Get.context!).notFinishRide),
    ProblemModel(id: 7, name: S.of(Get.context!).other),
  ];
}
