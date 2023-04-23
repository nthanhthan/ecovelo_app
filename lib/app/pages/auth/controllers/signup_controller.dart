import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
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

  String get name => nameFieldController.text.trim();

  String get email => emailController.text.trim();

  bool _passMatch = false;

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
      _passMatch = true;
      return null;
    } else {
      _passMatch = false;
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
        _passMatch == false) {
      return false;
    } else {
      return true;
    }
  }

  void checkFormValidation() {
    if (phoneNumber.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        email.isEmpty ||
        _passMatch == false) {
      enableSignUpBtn = false;
    } else {
      enableSignUpBtn = true;
    }
  }
}
