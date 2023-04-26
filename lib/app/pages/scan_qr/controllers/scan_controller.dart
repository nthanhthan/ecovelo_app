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

  final _isEnableFlash = false.obs;
  bool get isEnableFlash => _isEnableFlash.value;
  set isEnableFlash(bool value) => _isEnableFlash.value = value;

  late ScanHttpService _scanHttpService;

  @override
  void onInit() {
    _scanHttpService = Get.find<ScanHttpService>();
    super.onInit();
  }

  void setQrCodeScan(QRViewController cont) {
    qrController = cont;
    qrController?.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code != _qrCodeScanned) {
        await qrController?.pauseCamera();
        final result = await _scanHttpService.checkQR(scanData.code!);
        if (result.isSuccess() && result.data != null) {
          if (result.data == true) {
            Get.offNamed(
              Routes.rentBicycle,
              arguments: scanData.code,
            );
          } else {
            SnackBars.error(message: S.current.errorQR).show();
            resetScan();
          }
        } else {
          SnackBars.error(message: S.current.errorQR).show();
          resetScan();
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

  Future<void> resetScan() async {
    await Future.delayed(const Duration(seconds: 2));
    qrController?.resumeCamera();
  }
}
