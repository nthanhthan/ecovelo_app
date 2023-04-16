import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class ReportProblemController extends GetxController {
  final RxnInt _isProblem = RxnInt();
  set isProblem(int? value) => _isProblem.value = value;
  int? get isProblem => _isProblem.value;

  TextEditingController desciptionProblemController = TextEditingController();
  FocusNode desFocus = FocusNode();

  void selectProblem(int index) {
    isProblem = index;
  }
}
