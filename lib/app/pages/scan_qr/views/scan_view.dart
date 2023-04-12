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

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    _checkCameraPermission(context);
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              SvgPicture.asset(AssetsConst.logoSplash),
              const SizedBox(height: 15),
              Text(
                S.of(context).scanToRide,
                style: AppTextStyles.subHeading1()
                    .copyWith(color: AppColors.main.shade300),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isCameraPermissionGranted) {
                    return Stack(
                      children: [
                        _buildQrView(context),
                        _buildActions(context),
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
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 12, 8),
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Theme.of(context).dividerColor,
                child: IconButton(
                  onPressed: () async {
                    await controller.qrController?.toggleFlash();
                    controller.isEnableFlash = !controller.isEnableFlash;
                  },
                  icon: Obx(
                    () {
                      if (controller.isEnableFlash) {
                        return const Icon(Icons.flash_off);
                      } else {
                        return const Icon(Icons.flash_on);
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 12, 8),
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Theme.of(context).dividerColor,
                child: IconButton(
                  onPressed: () async {
                    await controller.qrController?.flipCamera();
                    controller.isCameraBack = !controller.isCameraBack;
                  },
                  icon: Obx(
                    () {
                      if (controller.isCameraBack) {
                        return const Icon(Icons.flip_camera_ios_rounded);
                      } else {
                        return const Icon(Icons.flip_camera_ios_rounded);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: controller.qrKey,
      onQRViewCreated: controller.setQrCodeScan,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
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
