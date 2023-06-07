import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanController extends GetxController with GetSingleTickerProviderStateMixin, WidgetsBindingObserver{
  QRViewController? qrController;

  final _isCameraPermissionGranted = false.obs;
  bool get isCameraPermissionGranted => _isCameraPermissionGranted.value;
  set isCameraPermissionGranted(bool value) =>
      _isCameraPermissionGranted.value = value;

  String _qrCodeScanned = "";
  bool isShowingAskPermission = false;

  final _isEnableFlash = false.obs;
  bool get isEnableFlash => _isEnableFlash.value;
  set isEnableFlash(bool value) => _isEnableFlash.value = value;

  late ScanHttpService _scanHttpService;

  UserModel? userModel;

  late LoginManager _loginManager;

  @override
  void onInit() {
  WidgetsBinding.instance.addObserver(this);
    _scanHttpService = Get.find<ScanHttpService>();
    _loginManager = Get.find<LoginManager>();
    userModel = _loginManager.getUser();
    super.onInit();
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }

  void setQrCodeScan(QRViewController cont) {
    qrController = cont;
    qrController?.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code != _qrCodeScanned) {
        await qrController?.pauseCamera();
        double currentPoint =
            (userModel?.mainPoint ?? 0) + (userModel?.proPoint ?? 0);
        if (currentPoint >= 5000) {
          final result = await _scanHttpService.checkQR(scanData.code!);
          if (result.isSuccess() && result.data != null) {
            if (result.data == true) {
              Get.offNamed(
                Routes.rentBicycle,
                arguments: scanData.code,
              );
            } else {
              resetScan(S.current.errorQR);
            }
          } else {
            resetScan(S.current.errorQR);
          }
        } else {
          resetScan(S.current.score);
        }

        _qrCodeScanned = "";
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      qrController?.getFlashStatus().then((value) {
        isEnableFlash = (value ?? false);
      });
    });
  }

  Future<void> resetScan(String error) async {
    SnackBars.error(message: error).show();
    await Future.delayed(const Duration(seconds: 2));
    qrController?.resumeCamera();
  }
}
