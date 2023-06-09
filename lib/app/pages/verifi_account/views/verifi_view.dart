import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerifiAccountView extends GetView<VerifiAccountController> {
  const VerifiAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AssetsConst.leftArrow,
          ),
        ),
        elevation: 0.0,
        title: Text(
          S.of(context).verifiAcc,
          style: AppTextStyles.subLead().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.grey.shade700,
          ),
        ),
        backgroundColor: AppColors.defaultBackground,
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 5,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.main.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              S.of(context).submitBtn,
              style: AppTextStyles.body1().copyWith(
                color: AppColors.main.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: AppColors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                S.of(context).messVerifi,
                style: AppTextStyles.body2().copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.main.shade300,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            _chooseType(context),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  S.of(context).takeTowSide,
                  style: AppTextStyles.body1(),
                ),
                const SizedBox(width: 20),
                SvgPicture.asset(
                  AssetsConst.cameraIc,
                  height: 40,
                )
              ],
            ),
            const SizedBox(height: 20),
            _takePhoto(context),
          ],
        ),
      ),
    );
  }

  Widget _chooseType(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomChooseType(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey.shade600,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetsConst.cardPerson,
              height: 30,
            ),
            const SizedBox(width: 10),
            Obx(
              () => Text(
                controller.nameDocument.isEmpty
                    ? S.of(context).choosePersonal
                    : controller.nameDocument,
                style: AppTextStyles.body2().copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.grey.shade500,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _takePhoto(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() {
              List<String> fileList = controller.filesPathFrontSelected;
              return UploadFileInput(
                title: S.of(context).frontView,
                filesSelected: fileList,
                onAddedNewFile: controller.pickFileFront,
                onRemovedFile: controller.removeFileFront,
                isSinglePick: true,
                iconUpload: AssetsConst.uploadImage,
                fileFormats: const ['jpg', 'png'],
              );
            }),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() {
              List<String> fileList = controller.filesPathBackSelected;
              return UploadFileInput(
                title: S.of(context).backView,
                filesSelected: fileList,
                onAddedNewFile: controller.pickFileBack,
                onRemovedFile: controller.removeFileBack,
                isSinglePick: true,
                iconUpload: AssetsConst.uploadImage,
                fileFormats: const ['jpg', 'png'],
              );
            }),
          ),
        ),
      ],
    );
  }

  void showBottomChooseType(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).choosePersonal,
                style: AppTextStyles.body1(),
              ),
              _itemDocument(
                context,
                S.of(context).citizenID,
              ),
              _itemDocument(
                context,
                S.of(context).cmnd,
              ),
              _itemDocument(
                context,
                S.of(context).license,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _itemDocument(
    BuildContext context,
    String name,
  ) {
    return GestureDetector(
      onTap: () {
        controller.nameDocument = name;
        Navigator.of(context).pop();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.grey.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          name,
          style: AppTextStyles.body2().copyWith(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
