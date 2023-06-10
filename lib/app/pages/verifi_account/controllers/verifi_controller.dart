import 'package:ecoveloapp/app/core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class VerifiAccountController extends GetxController {
  final _filesPathFrontSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathFrontSelected => _filesPathFrontSelected.value;
  set filesPathFrontSelected(List<String> value) =>
      _filesPathFrontSelected.value = value;

  final _filesPathBackSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathBackSelected => _filesPathBackSelected.value;
  set filesPathBackSelected(List<String> value) =>
      _filesPathBackSelected.value = value;

  final RxString _nameDocument = "".obs;
  set nameDocument(String name) => _nameDocument.value = name;
  String get nameDocument => _nameDocument.value;

  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  FirebaseStorage storage = FirebaseStorage.instance;

  String? urlFront;

  String? urlBack;

  late LoginManager _loginManager;

  LoginResp? userModel;

  late VerifyAccountService _verifyAccountService;

  LegalModel? _legalModel;

  @override
  void onInit() {
    _loginManager = Get.find<LoginManager>();
    userModel = _loginManager.getLogin();
    _verifyAccountService = Get.find<VerifyAccountService>();
    super.onInit();
  }

  void pickFileFront(String path) {
    filesPathFrontSelected.add(path);
    _filesPathFrontSelected.refresh();
    checkFormValidation();
  }

  void removeFileFront(String path) {
    filesPathFrontSelected.removeWhere((element) => element == path);
    _filesPathFrontSelected.refresh();
    checkFormValidation();
  }

  void pickFileBack(String path) {
    filesPathBackSelected.add(path);
    _filesPathBackSelected.refresh();
    checkFormValidation();
  }

  void removeFileBack(String path) {
    filesPathBackSelected.removeWhere((element) => element == path);
    _filesPathBackSelected.refresh();
    checkFormValidation();
  }

  void checkFormValidation() {
    if (filesPathFrontSelected.isNotEmpty &&
        filesPathBackSelected.isNotEmpty &&
        nameDocument.isNotEmpty) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }

  void selectLegal(LegalModel legalModel) {
    _legalModel = legalModel;
    nameDocument = _legalModel?.name ?? "";
    checkFormValidation();
  }

  Future<void> uploadProfile() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    Reference refFront =
        storage.ref().child("profile/${userModel?.userResponse?.userId}/front");
    Reference refBack =
        storage.ref().child("profile/${userModel?.userResponse?.userId}/back");
    File fileFront = File(filesPathFrontSelected.first);
    File fileBack = File(filesPathBackSelected.first);
    UploadTask taskFront = refFront.putFile(fileFront);
    UploadTask taskBack = refBack.putFile(fileBack);
    try {
      await taskFront.whenComplete(() async {
        urlFront = await refFront.getDownloadURL();
      });
      await taskBack.whenComplete(() async {
        urlBack = await refBack.getDownloadURL();
      });
      String token = Prefs.getString(SessionStoreKey.accessTokenKey);
      VerifyReq verifyReq = VerifyReq(
        urlBack: urlBack,
        urlFront: urlFront,
        idLegal: _legalModel?.id ?? 0,
        token: token,
      );
      final res = await _verifyAccountService.verifyAccount(verifyReq);
      if (res.isSuccess() && res.data != null && res.data == true) {
        Prefs.saveBool(AppKeys.isverify, true);
        processingDialog.hide();
        Get.offNamed(Routes.home);
      } else {
        processingDialog.hide();
        SnackBars.error(message: S.of(Get.context!).uploadError).show();
      }
    } catch (error) {
      processingDialog.hide();
      SnackBars.error(message: S.of(Get.context!).uploadError).show();
    }
  }
}
