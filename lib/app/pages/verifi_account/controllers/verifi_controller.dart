import 'package:ecoveloapp/app/core.dart';

class VerifiAccountController extends GetxController {
  final _filesPathFrontSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathFrontSelected => _filesPathFrontSelected.value;
  set filesPathFrontSelected(List<String> value) => _filesPathFrontSelected.value = value;

  final _filesPathBackSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathBackSelected => _filesPathBackSelected.value;
  set filesPathBackSelected(List<String> value) => _filesPathBackSelected.value = value;

  final RxString _nameDocument = "".obs;
  set nameDocument(String name) => _nameDocument.value = name;
  String get nameDocument => _nameDocument.value;

  void pickFileFront(String path) {
    filesPathFrontSelected.add(path);
    _filesPathFrontSelected.refresh();
    _checkFormValidation();
  }

  void removeFileFront(String path) {
    filesPathFrontSelected.removeWhere((element) => element == path);
    _filesPathFrontSelected.refresh();
    _checkFormValidation();
  }
    void pickFileBack(String path) {
    filesPathBackSelected.add(path);
    _filesPathBackSelected.refresh();
    _checkFormValidation();
  }

  void removeFileBack(String path) {
    filesPathBackSelected.removeWhere((element) => element == path);
    _filesPathBackSelected.refresh();
    _checkFormValidation();
  }

  void _checkFormValidation() {
    if (filesPathFrontSelected.isNotEmpty && filesPathBackSelected.isNotEmpty) {
      //enableSaveButton = true;
    } else {
      // enableSaveButton = false;
    }
  }
}
