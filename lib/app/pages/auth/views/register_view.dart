import 'package:ecoveloapp/app/core.dart';
import 'package:ecoveloapp/app/pages/auth/controllers/signup_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterView extends GetView<SignUpController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _formOnChange() {
    controller.checkFormValidation();
  }

  void _signInOnClicked() {
    Get.offAllNamed(Routes.signin);
  }

  void _signupOnClicked() {
    Get.offAllNamed(Routes.signin);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(AssetsConst.imageSignIn),
          Padding(
            padding: const EdgeInsets.only(top: 205),
            child: _mainSignIn(context),
          ),
          Positioned(
            right: 0,
            top: 60,
            child: Image.asset(
              AssetsConst.ecovelo,
              height: 260,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainSignIn(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: AppColors.defaultBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: _buildLoginView(context),
      ),
    );
  }

  Widget _buildLoginView(BuildContext context) {
    return Form(
      onChanged: _formOnChange,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.phoneNumberFieldController,
              keyboardType: TextInputType.phone,
              cursorColor: AppColors.main,
              focusNode: controller.phoneNode,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android_outlined,
                  color: AppColors.grey.shade200,
                ),
                hintText: S.of(context).phoneNumber,
                hintStyle: AppTextStyles.body1().copyWith(
                  color: AppColors.grey.shade300,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.grey.shade300,
                  ),
                ),
                filled: true,
                fillColor: AppColors.grey.shade600,
                errorMaxLines: 3,
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.nameFieldController,
              keyboardType: TextInputType.text,
              cursorColor: AppColors.main,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.personal_injury_outlined,
                  color: AppColors.grey.shade200,
                ),
                hintText: S.of(context).name,
                hintStyle: AppTextStyles.body1().copyWith(
                  color: AppColors.grey.shade300,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.grey.shade300,
                  ),
                ),
                filled: true,
                fillColor: AppColors.grey.shade600,
                errorMaxLines: 3,
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              cursorColor: AppColors.main,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.grey.shade200,
                ),
                hintText: S.of(context).email,
                hintStyle: AppTextStyles.body1().copyWith(
                  color: AppColors.grey.shade300,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.grey.shade300,
                  ),
                ),
                filled: true,
                fillColor: AppColors.grey.shade600,
                errorMaxLines: 3,
              ),
              validator: (text) {
                return controller.accountValidation(text?.trim());
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              maxLines: 1,
              obscureText: true,
              controller: controller.passwordFieldController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: AppColors.main,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_open_outlined,
                  color: AppColors.grey.shade200,
                ),
                hintText: S.of(context).password,
                hintStyle: AppTextStyles.body1().copyWith(
                  color: AppColors.grey.shade300,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.grey.shade300,
                  ),
                ),
                filled: true,
                fillColor: AppColors.grey.shade600,
                errorMaxLines: 3,
              ),
              validator: controller.passwordValidation,
            ),
            const SizedBox(height: 15),
            TextFormField(
              maxLines: 1,
              obscureText: true,
              textInputAction: TextInputAction.done,
              controller: controller.passWordAgainController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: AppColors.main,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_clock,
                  color: AppColors.grey.shade200,
                ),
                hintText: S.of(context).passWordAgain,
                hintStyle: AppTextStyles.body1().copyWith(
                  color: AppColors.grey.shade300,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.grey.shade300,
                  ),
                ),
                filled: true,
                fillColor: AppColors.grey.shade600,
                errorMaxLines: 3,
              ),
              validator: (text) {
                return controller.passWordAgain(text?.trim());
              },
            ),
            const SizedBox(height: 30),
            Obx(
              () {
                return ElevatedButton(
                  style: controller.enableSignUpBtn
                      ? FilledBtnStyle.enable(
                          sizeType: SizeButtonType.custom,
                          customPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                          isFullWidth: true,
                          borderRadius: 16,
                        )
                      : FilledBtnStyle.disable(
                          sizeType: SizeButtonType.custom,
                          customPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                          isFullWidth: true,
                          borderRadius: 16,
                        ),
                  onPressed: controller.enableSignUpBtn == true
                      ? _signupOnClicked
                      : null,
                  child: Text(
                    S.of(context).signUp,
                    style: AppTextStyles.body1().copyWith(
                      color: AppColors.main.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: S.of(context).haveAccount,
                        style: AppTextStyles.body2().copyWith(
                          color: AppColors.grey.shade300,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: "  "),
                      TextSpan(
                        text: S.of(context).signIn,
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.main.shade200),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _signInOnClicked,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
