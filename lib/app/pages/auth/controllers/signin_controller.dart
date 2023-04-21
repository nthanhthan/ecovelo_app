import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class SignInController extends GetxController {
  final loginFormGlobalKey = GlobalKey<FormState>();
  TextEditingController accountFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  FocusNode accountNode = FocusNode();
  final _enableSignInBtn = false.obs;

  bool get enableSignInBtn => _enableSignInBtn.value;

  set enableSignInBtn(bool value) => _enableSignInBtn.value = value;

  String get account => accountFieldController.text.trim();

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
    } else if (!StringExtensions(value).isLeastOneNumber()) {
      return S.current.invalidPasswordOneNumber;
    } else {
      return null;
    }
  }

  bool get isFormValided {
    if (account.isEmpty || password.isEmpty) {
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
