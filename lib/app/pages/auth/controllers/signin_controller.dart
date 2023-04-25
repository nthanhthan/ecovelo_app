import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class SignInController extends GetxController {
  final loginFormGlobalKey = GlobalKey<FormState>();
  TextEditingController accountFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  FocusNode accountNode = FocusNode();
  final RxBool _enableSignInBtn = false.obs;
  late LoginManager _loginManager;

  late final AuthHttpService _authHttpService;

  bool get enableSignInBtn => _enableSignInBtn.value;

  set enableSignInBtn(bool value) => _enableSignInBtn.value = value;

  String get account => accountFieldController.text.trim();

  String get password => passwordFieldController.text.trim();

  String? accountValidation(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return S.current.enterPhone;
    } else if (!regExp.hasMatch(value)) {
      return S.current.validatePhone;
    }
    return null;
  }

  @override
  void onInit() {
    _authHttpService = Get.find<AuthHttpService>();
    _loginManager = Get.find<LoginManager>();
    accountNode.addListener(() {
      accountFieldController.text = accountFieldController.text.trim();
    });
    super.onInit();
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
    if (isFormValided) {
      enableSignInBtn = true;
    } else {
      enableSignInBtn = false;
    }
  }

  Future<void> signIn() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final res =
        await _authHttpService.login(userName: account, password: password);
    if (res.isSuccess() && res.data != null) {
      _loginManager.saveUser(res.data);
      processingDialog.hide();
      Get.offNamed(Routes.home);
    } else {
      processingDialog.hide();
      accountNode.requestFocus();
      SnackBars.error(message: S.current.erEmailOrPasswordInvalid).show();
    }
  }
}
