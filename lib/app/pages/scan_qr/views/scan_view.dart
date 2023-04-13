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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: AppColors.white,
          leading: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.main.shade200),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.grey.shade100,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 40),
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
              Expanded(
                child: Obx(() {
                  if (controller.isCameraPermissionGranted) {
                    return _buildQrView(context);
                  } else {
                    return Center(
                      child: Text(S.of(context).noCameraPermissionDesctiption),
                    );
                  }
                }),
              ),
              _buildActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 30, 12, 15),
        child: CircleAvatar(
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
                  return const Icon(Icons.flash_on, color: AppColors.main);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 500 ||
            MediaQuery.of(context).size.height < 800)
        ? 400.0
        : 600.0;
    return QRView(
      key: controller.qrKey,
      onQRViewCreated: controller.setQrCodeScan,
      overlay: QrScannerOverlayShape(
          borderColor: AppColors.main.shade200,
          overlayColor: AppColors.defaultBackground,
          borderRadius: 8,
          borderLength: 17,
          borderWidth: 5,
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
