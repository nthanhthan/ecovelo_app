import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({Key? key}) : super(key: key);
  void _checkCameraPermission(BuildContext context) async {
    var status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      controller.isCameraPermissionGranted = true;
    } else if (status == PermissionStatus.permanentlyDenied) {
      if (!controller.isShowingAskPermission) {
        controller.isShowingAskPermission = true;
        await Get.dialog<void>(
          BasePopup(
            title: Text(
              S.of(context).unableToAccessCamera,
              style: const TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.start,
            ),
            body: Text(S.of(context).cameraAccessDenied),
            actions: [
              TextButton(
                onPressed: () async {
                  Get.back<void>();
                  await openAppSettings();
                  _checkCameraPermission(context);
                },
                child: Text(S.of(context).ok),
              ),
            ],
          ),
        );
        controller.isShowingAskPermission = false;
      }
    }
  }

  void _encodeCodeClicked() {
    double currentPoint = (controller.userModel?.mainPoint ?? 0) +
        (controller.userModel?.proPoint ?? 0);
    Get.offNamed(
      Routes.enterCode,
      arguments: currentPoint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    _checkCameraPermission(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.defaultBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: AppColors.white,
          leading: InkWell(
            onTap: () {
              Get.offNamed(Routes.home);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Color(0xff28303f),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              AssetsConst.logoScanner,
              height: 60,
            ),
            const SizedBox(height: 15),
            Text(
              S.of(context).scanToRide,
              style: AppTextStyles.subHeading1()
                  .copyWith(color: AppColors.main.shade300),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Obx(() {
                if (controller.isCameraPermissionGranted) {
                  return Stack(
                    children: [
                      _buildQrView(context),
                      Positioned(
                        top: 10,
                        right: 20,
                        child: _buildActions(context),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(S.of(context).noCameraPermissionDesctiption),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).dividerColor,
          child: IconButton(
            onPressed: _encodeCodeClicked,
            icon: const Icon(
              Icons.keyboard,
              color: AppColors.main,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).dividerColor,
          child: IconButton(
            onPressed: () async {
              await controller.qrController?.toggleFlash();
              controller.isEnableFlash = !controller.isEnableFlash;
            },
            icon: Obx(
              () {
                if (controller.isEnableFlash) {
                  return const Icon(
                    Icons.flash_off,
                    color: AppColors.main,
                  );
                } else {
                  return const Icon(
                    Icons.flash_on,
                    color: AppColors.main,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: controller.setQrCodeScan,
      overlay: QrScannerOverlayShape(
          borderColor: AppColors.main.shade200,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    LogUtil.d('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).noCameraPermissionDesctiption)),
      );
    }
  }
}
