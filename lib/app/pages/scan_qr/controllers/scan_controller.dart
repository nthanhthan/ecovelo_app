import 'package:ecoveloapp/app/core.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanController extends GetxController {
  late QRViewController? qrController;

  final _isCameraPermissionGranted = false.obs;
  bool get isCameraPermissionGranted => _isCameraPermissionGranted.value;
  set isCameraPermissionGranted(bool value) =>
      _isCameraPermissionGranted.value = value;

  String _qrCodeScanned = "";
  bool isShowingAskPermission = false;

  final _isCameraBack = false.obs;
  bool get isCameraBack => _isCameraBack.value;
  set isCameraBack(bool value) => _isCameraBack.value = value;

  final _isEnableFlash = false.obs;
  bool get isEnableFlash => _isEnableFlash.value;
  set isEnableFlash(bool value) => _isEnableFlash.value = value;

  void setQrCodeScan(QRViewController cont) {
    qrController = cont;
    qrController?.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && _qrCodeScanned != scanData.code) {
        _qrCodeScanned = scanData.code ?? "";
        await qrController?.pauseCamera();
        //code
        Get.offNamed(
          Routes.rentBicycle,
          arguments: _qrCodeScanned,
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      qrController?.getCameraInfo().then((value) {
        isCameraBack = (value == CameraFacing.back);
      });
      qrController?.getFlashStatus().then((value) {
        isEnableFlash = (value ?? false);
      });
    });
  }
}
