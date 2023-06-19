import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMoneyController extends GetxController {
  late final TextEditingController _enterMoneyController;
  TextEditingController get enterMoneyController => _enterMoneyController;
  set enterMoneyController(value) => _enterMoneyController.value = value;
  late StripeService stripeService;

  String formatNumber(String s) =>
      NumberFormat.decimalPattern('en').format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: 'en').currencySymbol;

  final RxInt _indexMoney = 0.obs;
  set indexMoney(int value) => _indexMoney.value = value;
  int get indexMoney => _indexMoney.value;

  final RxInt _indexBank = 0.obs;
  set indexBank(int value) => _indexBank.value = value;
  int get indexBank => _indexBank.value;

  LoginResp? loginResp;

  late LoginManager _loginManager;

  int addMoney = 0;

  late AddMoneyService _addMoneyService;

  @override
  void onInit() {
    _enterMoneyController = TextEditingController();
    _loginManager = Get.find<LoginManager>();
    loginResp = _loginManager.getLogin();
    _addMoneyService = Get.find<AddMoneyService>();
    enterMoneyController.text =
        parseMoney(DefaultValues.addMoneyValues[indexMoney].money);
    addMoney = DefaultValues.addMoneyValues[indexMoney].money ?? 0;
    stripeService = Get.find<StripeService>();
    super.onInit();
  }

  String parseMoney(int? money) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(money ?? 0);
  }

  void selectedMoney(MoneyModel moneyModel) {
    indexMoney = moneyModel.id ?? 0;
    addMoney = moneyModel.money ?? 0;
    enterMoneyController.text = parseMoney(moneyModel.money);
  }

  void selectedBank(BankModel bankModel) {
    indexBank = bankModel.id;
  }

  Future<bool> payment() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();

    if (loginResp != null && loginResp!.userResponse != null) {
      try {
        await stripeService.payment(
          loginResp!.userResponse!.userId.toString(),
          addMoney,
        );
        TransactionReq transactionReq = TransactionReq(
          money: addMoney,
          titleTransaction: "Transfer Money from Stripe",
          isMainPoint: true,
          isStatus: true,
        );
        final result =
            await _addMoneyService.addMoney(transactionReq: transactionReq);
        if (result.isSuccess() && result.data != null) {
          processingDialog.hide();
          Get.offAllNamed(
            Routes.transferSuccess,
            arguments: result.data,
          );
          return true;
        } else {
          processingDialog.hide();
          ToastMessage.error(message: S.of(Get.context!).transferError);
          return false;
        }
      } catch (e) {
        processingDialog.hide();
        ToastMessage.error(message: S.of(Get.context!).transferError);
        return false;
      }
    } else {
      processingDialog.hide();
      return false;
    }
  }
}
