import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class EnterCodeController extends GetxController {
  TextEditingController codeEcoveloController = TextEditingController();
  FocusNode codeFocus = FocusNode();

  final RxBool _isCodeNotNull = false.obs;
  set isCodeNotNull(bool value) => _isCodeNotNull.value = value;
  bool get isCodeNotNull => _isCodeNotNull.value;

  late ScanHttpService _scanHttpService;

  double? pointUser;

  late ScanController _scanController;

  @override
  void onInit() {
    _scanHttpService = Get.find<ScanHttpService>();
    _scanController = Get.find<ScanController>();
    if (Get.arguments != null && Get.arguments is double) {
      pointUser = Get.arguments as double;
    }
    super.onInit();
  }

  Future<void> checkCode() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    if (_scanController.userModel?.verify == true) {
      if (pointUser != null && pointUser! >= 5000) {
        final result =
            await _scanHttpService.checkQR(codeEcoveloController.text.trim());
        if (result.isSuccess() && result.data != null) {
          if (result.data == true) {
            Get.offNamed(
              Routes.rentBicycle,
              arguments: codeEcoveloController.text.trim(),
            );
          } else {
            processingDialog.hide();
            resetScan(S.of(Get.context!).errorQR);
          }
        } else {
          processingDialog.hide();
          resetScan(S.of(Get.context!).errorQR);
        }
      } else {
        processingDialog.hide();
        resetScan(S.of(Get.context!).score);
      }
    } else {
      processingDialog.hide();
      resetScan(S.of(Get.context!).accountMustVeifi);
    }
  }

  Future<void> resetScan(String error) async {
    SnackBars.error(message: error).show();
    await Future.delayed(const Duration(seconds: 2));
  }
}
