import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class ReportProblemController extends GetxController {
  final RxnInt _isProblem = RxnInt();
  set isProblem(int? value) => _isProblem.value = value;
  int? get isProblem => _isProblem.value;

  TextEditingController desciptionProblemController = TextEditingController();
  FocusNode desFocus = FocusNode();

  final _filesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathSelected => _filesPathSelected.value;
  set filesPathSelected(List<String> value) => _filesPathSelected.value = value;

  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  void selectProblem(int index) {
    isProblem = index;
    _checkFormValidation();
  }

  void pickFile(String path) {
    filesPathSelected.add(path);
    _filesPathSelected.refresh();
    _checkFormValidation();
  }

  void removeFile(String path) {
    filesPathSelected.removeWhere((element) => element == path);
    _filesPathSelected.refresh();
    _checkFormValidation();
  }

  void _checkFormValidation() {
    if (filesPathSelected.isNotEmpty && isProblem != null) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }
}
