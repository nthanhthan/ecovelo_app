import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight = newValue.text.length - newValue.selection.end;
      final oCcy = NumberFormat.decimalPattern(Platform.localeName);
      int num = int.parse(newValue.text.replaceAll(oCcy.symbols.GROUP_SEP, ''));
      final newString = oCcy.format(num);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
