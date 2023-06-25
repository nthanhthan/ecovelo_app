import 'dart:io';

import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
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

  bool isReport = false;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    _scanHttpService = Get.find<ScanHttpService>();
    _loginManager = Get.find<LoginManager>();
    userModel = _loginManager.getUser();
    if (Get.arguments != null && Get.arguments is bool) {
      isReport = true;
    }
    super.onInit();
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }

  void setQrCodeScan(QRViewController cont) {
    qrController = cont;
    if (Platform.isAndroid) {
      qrController?.resumeCamera();
    }
    qrController?.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code != _qrCodeScanned) {
        await qrController?.pauseCamera();
        double currentPoint =
            (userModel?.mainPoint ?? 0) + (userModel?.proPoint ?? 0);
        if (userModel?.verify == true) {
          if (currentPoint >= 5000) {
            final result = await _scanHttpService.checkQR(scanData.code!);
            if (result.isSuccess() && result.data != null) {
              if (result.data == true) {
                Get.offNamed(
                  Routes.rentBicycle,
                  arguments: scanData.code,
                );
              } else {
                resetScan(S.of(Get.context!).errorQR);
              }
            } else {
              resetScan(S.of(Get.context!).errorQR);
            }
          } else {
            resetScan(S.of(Get.context!).score);
          }

          _qrCodeScanned = "";
        } else {
          resetScan(S.of(Get.context!).accountMustVeifi);
        }
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      qrController?.getFlashStatus().then((value) {
        isEnableFlash = (value ?? false);
      });
    });
  }

  void checkBicycleID(QRViewController cont) {
    qrController = cont;
    if (Platform.isAndroid) {
      qrController?.resumeCamera();
    }
    qrController?.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code != _qrCodeScanned) {
        await qrController?.pauseCamera();
        final result = await _scanHttpService.checkQR(
          scanData.code!,
          isReport: true,
        );
        if (result.isSuccess() && result.data != null) {
          if (result.data == true) {
            Get.back(result: scanData.code);
          } else {
            resetScan(S.of(Get.context!).errorQR);
          }
        } else {
          resetScan(S.of(Get.context!).errorQR);
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
