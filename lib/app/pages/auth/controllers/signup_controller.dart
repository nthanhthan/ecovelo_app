import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
  final signUpFormGlobalKey = GlobalKey<FormState>();
  TextEditingController phoneNumberFieldController = TextEditingController();
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordAgainController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  FocusNode phoneNode = FocusNode();

  final RxBool _enableSignUpBtn = false.obs;

  set enableSignUpBtn(bool value) => _enableSignUpBtn.value = value;

  bool get enableSignUpBtn => _enableSignUpBtn.value;

  String get phoneNumber => phoneNumberFieldController.text.trim();

  String get password => passwordFieldController.text.trim();
  String get passwordAgain => passWordAgainController.text.trim();

  String get name => nameFieldController.text.trim();

  String get email => emailController.text.trim();

  late final AuthHttpService _authHttpService;

  @override
  void onInit() {
    _authHttpService = Get.find<AuthHttpService>();
    phoneNode.addListener(() {
      phoneNumberFieldController.text = phoneNumberFieldController.text.trim();
    });
    super.onInit();
  }

  String? accountValidation(String? value) {
    if (value != null && StringExtensions(value).isEmail()) {
      return null;
    } else {
      return S.current.invalidEmailAddress;
    }
  }

  String? phoneValidation(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return S.current.enterPhone;
    } else if (!regExp.hasMatch(value)) {
      return S.current.validatePhone;
    }
    return null;
  }

  String? passWordAgain(String? value) {
    if (value != null && value == password) {
      return null;
    } else {
      return S.current.noMatchPass;
    }
  }

  String? passwordValidation(String? value) {
    if (value == null || value.length < 8) {
      return S.current.invalidPasswordLength;
    } else if (!StringExtensions(value).isLeastOneLetter()) {
      return S.current.invalidPasswordOneLetter;
    } else if (!StringExtensions(value).isLeastOneNumber()) {
      return S.current.invalidPasswordOneNumber;
    } else {
      return null;
    }
  }

  bool get isFormValided {
    if (phoneNumber.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        email.isEmpty ||
        passwordAgain.isEmpty) {
      return false;
    } else {
      return signUpFormGlobalKey.currentState?.validate() ?? false;
    }
  }

  void checkFormValidation() {
    if (isFormValided) {
      enableSignUpBtn = true;
    } else {
      enableSignUpBtn = false;
    }
  }

  Future<void> signUpClick() async {
    SignUpReq signUpReq = SignUpReq(
      phoneNumber: phoneNumber,
      email: email,
      nameUser: name,
      password: password,
    );
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final res = await _authHttpService.signUp(signUpReq);
    if (res.isSuccess() && res.data != null) {
      processingDialog.hide();
      phoneNumberFieldController.clear();
      nameFieldController.clear();
      emailController.clear();
      passwordFieldController.clear();
      passWordAgainController.clear();
      Get.back();
    } else {
      processingDialog.hide();
      SnackBars.error(message: S.current.erEmailOrPasswordInvalid).show();
    }
  }
}
