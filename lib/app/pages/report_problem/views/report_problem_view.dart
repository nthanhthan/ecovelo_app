import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReportProblemView extends GetView<ReportProblemController> {
  const ReportProblemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _submitonClicked() {
    controller.uploadFile();
  }

  void goBackToHome() {
    Get.offAllNamed(Routes.home);
  }

  Future<void> scanBicycleID() async {
    String result = await Get.toNamed(
      Routes.scanQR,
      arguments: true,
    );
    controller.ecoveloID.text = result;
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
          onTap: () {
            controller.enableSaveButton ? _submitonClicked() : null;
          },
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
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 50,
                ),
                child: Center(
                  child: TextFieldInput(
                    key: const ValueKey('ecoveloID'),
                    isApplyFirstCharacterCapitalization: false,
                    fillColor: AppColors.white,
                    inputBorderColor: AppColors.main,
                    disableBorderColor: AppColors.grey.shade400,
                    hintText: S.of(context).enterCode,
                    inputBorderType: InputBorderType.underline,
                    inputController: controller.ecoveloID,
                    tagId: "ecoveloID",
                    textInputAction: TextInputAction.newline,
                    maxLines: 1,
                    suffixIcon: GestureDetector(
                        onTap: scanBicycleID,
                        child: Lottie.asset(AssetsConst.qrScan, height: 50)),
                    textStyle: AppTextStyles.heading2().copyWith(
                      color: AppColors.main.shade200,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              _titleWidget(
                context,
                S.of(context).selectProblem,
              ),
              Wrap(
                children: DefaultValues.listProblems.asMap().entries.map((e) {
                  return _contentProblem(
                    context,
                    DefaultValues.listProblems[e.key],
                  );
                }).toList(),
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
                  textAlign: TextAlign.start,
                  disableBorderColor: AppColors.grey.shade400,
                  inputController: controller.desciptionProblemController,
                  tagId: "desciption",
                  textInputAction: TextInputAction.newline,
                  hintTextStyle: AppTextStyles.tiny().copyWith(
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

  Widget _contentProblem(BuildContext context, ProblemModel problemModel) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            controller.selectProblem(problemModel);
          },
          style: FilledBtnStyle.enable(
            sizeType: SizeButtonType.custom,
            customPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            background: controller.isProblem == problemModel.id
                ? AppColors.main.shade200
                : AppColors.grey.shade100,
            borderRadius: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 17.0,
                height: 17.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: controller.isProblem == problemModel.id
                        ? AppColors.main.shade400
                        : AppColors.main.shade200,
                    width: controller.isProblem == problemModel.id ? 5.0 : 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                problemModel.name ?? "",
                style: AppTextStyles.body2().copyWith(
                  color: controller.isProblem == problemModel.id
                      ? AppColors.main.shade400
                      : AppColors.main.shade200,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void reportSuccess(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(children: [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).reportSend,
                          style: AppTextStyles.subHeading1().copyWith(
                            color: AppColors.main.shade200,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        S.of(context).desReport,
                        style: AppTextStyles.body2().copyWith(
                          color: AppColors.main.shade200,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 30),
                      OutlinedButton(
                        onPressed: () {
                          goBackToHome();
                        },
                        style: OutlineButtonStyle.enable(isFullWidth: true),
                        child: Text(
                          S.of(context).goBackHome,
                          style: AppTextStyles.body2().copyWith(
                            color: AppColors.main.shade200,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 110,
              child: Transform.translate(
                offset: const Offset(0, -60),
                child: Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.main,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
