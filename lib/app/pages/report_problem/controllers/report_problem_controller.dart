import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

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

  TextEditingController ecoveloID = TextEditingController();

  String? problemName;

  FirebaseStorage storage = FirebaseStorage.instance;

  String? url;

  void selectProblem(ProblemModel problemModel) {
    isProblem = problemModel.id;
    problemName = problemModel.name;
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
    if (filesPathSelected.isNotEmpty &&
        problemName != null &&
        ecoveloID.text.isNotEmpty) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }

  Future<void> uploadFile() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    Reference ref = storage
        .ref()
        .child("problem/${ecoveloID.text}/$problemName/${DateTime.now()}");
    File file = File(filesPathSelected.first);
    UploadTask task = ref.putFile(file);
    try {
      await task.whenComplete(() async {
        url = await ref.getDownloadURL();
      });

      processingDialog.hide();
      const ReportProblemView().reportSuccess(Get.context!);
    } catch (error) {
      processingDialog.hide();
      SnackBars.error(message: S.of(Get.context!).uploadError).show();
    }
  }
}
