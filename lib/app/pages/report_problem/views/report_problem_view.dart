import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class ReportProblemView extends GetView<ReportProblemController> {
  const ReportProblemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.defaultBackground,
        title: Text(
          S.of(context).reportProblem,
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.colorText,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Color(0xff28303f),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {},
          child: Obx(
            () => Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 5,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: controller.enableSaveButton
                    ? AppColors.main.shade200
                    : AppColors.grey.shade200,
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
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleWidget(
                context,
                S.of(context).bikeNumber,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    "ECO43-001",
                    style: AppTextStyles.heading2()
                        .copyWith(color: AppColors.main.shade200),
                  ),
                ),
              ),
              _titleWidget(
                context,
                S.of(context).selectProblem,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      _contentProblem(
                        context,
                        S.of(context).unlock,
                        0,
                      ),
                      _contentProblem(
                        context,
                        S.of(context).qrError,
                        1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _contentProblem(
                        context,
                        S.of(context).lockBroken,
                        2,
                      ),
                      _contentProblem(
                        context,
                        S.of(context).bikeVandalized,
                        3,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _contentProblem(
                        context,
                        S.of(context).notBuyMorePoint,
                        4,
                      ),
                      _contentProblem(
                        context,
                        S.of(context).flatTire,
                        5,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _contentProblem(
                        context,
                        S.of(context).notFinishRide,
                        6,
                      ),
                      _contentProblem(
                        context,
                        S.of(context).other,
                        7,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _titleWidget(
                context,
                S.of(context).titleDes,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFieldInput(
                  key: const ValueKey('desciption'),
                  hintText: S.of(context).hintDes,
                  fillColor: AppColors.white,
                  borderRadius: 16,
                  inputBorderColor: AppColors.main,
                  disableBorderColor: AppColors.grey.shade400,
                  inputController: controller.desciptionProblemController,
                  tagId: "desciption",
                  textInputAction: TextInputAction.newline,
                  hintTextStyle: AppTextStyles.body2().copyWith(
                    color: AppColors.grey.shade300,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 3,
                  textStyle: AppTextStyles.body2().copyWith(
                    color: AppColors.main.shade200,
                    fontWeight: FontWeight.w400,
                  ),
                  focusNode: controller.desFocus,
                  validator: (String? value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value.length > 255) {
                      return S.of(context).notesMustShorterThan;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _titleWidget(
                  context,
                  S.of(context).uploadImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(() {
                  List<String> fileList = controller.filesPathSelected;
                  return UploadFileInput(
                    title: S.of(context).uploadFile,
                    filesSelected: fileList,
                    onAddedNewFile: controller.pickFile,
                    onRemovedFile: controller.removeFile,
                    isSinglePick: true,
                    fileFormats: const ['jpg', 'png'],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyles.body2().copyWith(
        color: AppColors.grey.shade500,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _contentProblem(BuildContext context, String text, int isProblem) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              controller.selectProblem(isProblem);
            },
            style: FilledBtnStyle.enable(
              sizeType: SizeButtonType.custom,
              customPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              background: controller.isProblem == isProblem
                  ? AppColors.main.shade200
                  : AppColors.grey.shade100,
              borderRadius: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 17.0,
                  height: 17.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: controller.isProblem == isProblem
                          ? AppColors.main.shade400
                          : AppColors.main.shade200,
                      width: controller.isProblem == isProblem ? 5.0 : 1.0,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: AppTextStyles.body2().copyWith(
                    color: controller.isProblem == isProblem
                        ? AppColors.main.shade400
                        : AppColors.main.shade200,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
