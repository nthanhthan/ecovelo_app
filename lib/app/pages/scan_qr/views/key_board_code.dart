import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class KeyBoardCode extends GetView<EnterCodeController> {
  const KeyBoardCode({Key? key}) : super(key: key);
  void _continueClick() {
    controller.checkCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).enterCode,
          style: AppTextStyles.heading1().copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.offNamed(Routes.scanQR);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.grey.shade100,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).findCode,
            style: AppTextStyles.heading2().copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: TextFieldInput(
              key: const ValueKey('EcoveloCode'),
              isApplyFirstCharacterCapitalization: false,
              fillColor: AppColors.white,
              borderRadius: 20,
              inputBorderColor: AppColors.main,
              disableBorderColor: AppColors.grey.shade400,
              inputController: controller.codeEcoveloController,
              tagId: "ecoveloCode",
              textInputAction: TextInputAction.newline,
              maxLines: 1,
              textStyle: AppTextStyles.heading2().copyWith(
                color: AppColors.main.shade200,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (p0) {
                controller.isCodeNotNull = p0.isNotEmpty;
              },
              focusNode: controller.codeFocus,
            ),
          ),
          const SizedBox(height: 80),
          _btnWidget(context),
        ],
      ),
    );
  }

  Widget _btnWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Obx(() => ElevatedButton(
            key: const ValueKey('signInButton'),
            style: controller.isCodeNotNull == true
                ? FilledBtnStyle.enable(
                    sizeType: SizeButtonType.custom,
                    borderRadius: 16,
                    customPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 50,
                    ),
                  )
                : FilledBtnStyle.disable(
                    sizeType: SizeButtonType.custom,
                    borderRadius: 16,
                    customPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 50,
                    ),
                  ),
            onPressed: () {
               controller.isCodeNotNull == true
                   ? _continueClick()
                   : null;
            },
            child: Text(
              S.of(context).continueBtn,
              style: AppTextStyles.body1().copyWith(
                color: AppColors.main.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
    );
  }
}
