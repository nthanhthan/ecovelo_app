import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _formOnChange() {
    controller.checkFormValidation();
  }

  void _signInOnClicked() {}
  void _forgotPasswordOnClicked() {
    Get.offNamed(Routes.home);
  }

  void _signupOnClicked() {}

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      decoration: const BoxDecoration(
        color: AppColors.defaultBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
        child: _buildLoginView(context),
      ),
    );
  }

  Widget _buildLoginView(BuildContext context) {
    return Form(
      key: controller.loginFormGlobalKey,
      onChanged: _formOnChange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            key: const ValueKey('emailSignUpField'),
            maxLines: 1,
            textInputAction: TextInputAction.next,
            controller: controller.accountFieldController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
              LowerCaseTextFormatter(),
            ],
            focusNode: controller.accountNode,
            keyboardType: TextInputType.emailAddress,
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
              fillColor: AppColors.grey.shade500,
              errorMaxLines: 3,
            ),
            validator: (text) {
              return controller.accountValidation(text?.trim());
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            key: const ValueKey('passwordSignUpField'),
            maxLines: 1,
            obscureText: true,
            controller: controller.passwordFieldController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
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
              fillColor: AppColors.grey.shade500,
              errorMaxLines: 3,
            ),
            validator: controller.passwordValidation,
            onFieldSubmitted: (_) {
              if (controller.loginFormGlobalKey.currentState?.validate() ??
                  false) {
                _signInOnClicked();
              }
            },
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () {
                bool enable = controller.enableSignInBtn;
                ButtonStyle btnStyle = FilledBtnStyle.disable(
                  sizeType: SizeButtonType.custom,
                  borderRadius: 16,
                  customPadding: const EdgeInsets.symmetric(vertical: 15),
                );
                if (enable) {
                  btnStyle = FilledBtnStyle.enable(
                    sizeType: SizeButtonType.custom,
                    borderRadius: 16,
                    customPadding: const EdgeInsets.symmetric(vertical: 15),
                  );
                }
                return ElevatedButton(
                  key: const ValueKey('signInButton'),
                  style: btnStyle,
                  onPressed: _signInOnClicked,
                  child: Text(
                    S.of(context).signIn,
                    style: AppTextStyles.body1().copyWith(
                      color: AppColors.main.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text.rich(
              TextSpan(
                  text: S.of(context).forgotPassword,
                  style: AppTextStyles.body1().copyWith(
                    color: AppColors.main.shade200,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _forgotPasswordOnClicked),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: S.of(context).noAccount,
                        style: AppTextStyles.body2().copyWith(
                          color: AppColors.grey.shade200,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: "  "),
                      TextSpan(
                        text: S.of(context).signUp,
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.main.shade200),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _signupOnClicked,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}