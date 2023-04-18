import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
  final loginFormGlobalKey = GlobalKey<FormState>();
  TextEditingController phoneNumberFieldController = TextEditingController();
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController passWordAgainController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();

  final _enableSignInBtn = false.obs;

  bool get enableSignInBtn => _enableSignInBtn.value;

  set enableSignInBtn(bool value) => _enableSignInBtn.value = value;

  String get phoneNumber => phoneNumberFieldController.text.trim();

  String get password => passwordFieldController.text.trim();

  String? accountValidation(String? value) {
    if (value != null && StringExtensions(value).isEmail()) {
      return null;
    } else {
      return S.current.invalidEmailAddress;
    }
  }

  String? passwordValidation(String? value) {
    if (value == null || value.length < 8) {
      return S.current.invalidPasswordLength;
    } else if (!StringExtensions(value).isLeastOneLetter()) {
      return S.current.invalidPasswordOneLetter;
    } else if (!StringExtensions(value).isLeastOneCapitalLetter()) {
      return S.current.invalidPasswordOneCapitalLetter;
    } else if (!StringExtensions(value).isLeastOneNumber()) {
      return S.current.invalidPasswordOneNumber;
    } else if (!StringExtensions(value).isLeastOneSpecial()) {
      return S.current.invalidPasswordOneSpecialLetter;
    } else {
      return null;
    }
  }

  bool get isFormValided {
    if (phoneNumber.isEmpty || password.isEmpty) {
      return false;
    } else {
      return loginFormGlobalKey.currentState?.validate() ?? false;
    }
  }

  void checkFormValidation() {
    if (enableSignInBtn && !isFormValided) {
      enableSignInBtn = false;
    } else if (!enableSignInBtn && isFormValided) {
      enableSignInBtn = true;
    }
  }
}
