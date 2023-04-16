import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMoneyController extends GetxController {
  late final TextEditingController _enterMoneyController;
  TextEditingController get enterMoneyController => _enterMoneyController;
  set enterMoneyController(value) => _enterMoneyController.value = value;

  String formatNumber(String s) => NumberFormat.decimalPattern('en').format(int.parse(s));
  String get currency => NumberFormat.compactSimpleCurrency(locale: 'en').currencySymbol;

  var selectedBank = "Techcombank (TCB)".obs;

  @override
  void onInit() {
    _enterMoneyController = TextEditingController();
    super.onInit();
  }

  selectBank(String title){
    selectedBank.value = title;
  }
}