import 'dart:math';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PercentTextFormatter extends TextInputFormatter {
  static final NumberFormat _formatter = NumberFormat.decimalPattern(Platform.localeName);

  final FilteringTextInputFormatter _decimalFormatter;
  final String _decimalSeparator;
  final RegExp _decimalRegex;

  final NumberFormat? formatter;
  final bool allowFraction;

  TextEditingValue? _lastNewValue;

  PercentTextFormatter({this.formatter, this.allowFraction = false})
      : _decimalSeparator = (formatter ?? _formatter).symbols.DECIMAL_SEP,
        _decimalRegex = RegExp(allowFraction ? '[0-9]+([${(formatter ?? _formatter).symbols.DECIMAL_SEP}])?' : r'\d+'),
        _decimalFormatter =
            FilteringTextInputFormatter.allow(RegExp(allowFraction ? '[0-9]+([${(formatter ?? _formatter).symbols.DECIMAL_SEP}])?' : r'\d+'));

  String _formatPattern(String? digits) {
    if (digits == null || digits.isEmpty) return '';
    num number;
    String zeroEnd = "";
    if (allowFraction) {
      if (digits.contains(_decimalSeparator)) {
        String decimalPart = digits.split(_decimalSeparator).last;
        for (var i = decimalPart.length - 1; i >= 0 && decimalPart[i] == "0"; i--) {
          zeroEnd += (decimalPart[i] == "0" ? "0" : "");
        }
      }
      String decimalDigits = digits;
      if (_decimalSeparator != '.') {
        decimalDigits = digits.replaceFirst(RegExp(_decimalSeparator), '.');
      }
      number = double.tryParse(decimalDigits) ?? 0.0;
    } else {
      number = int.tryParse(digits) ?? 0;
    }

    final result = (formatter ?? _formatter).format(number);
    if (allowFraction && digits.endsWith(_decimalSeparator)) {
      return '$result$_decimalSeparator';
    }
    if (zeroEnd.isNotEmpty) {
      if (!result.contains(_decimalSeparator)) {
        return '$result$_decimalSeparator$zeroEnd';
      } else {
        return '$result$zeroEnd';
      }
    }
    return result;
  }

  TextEditingValue _formatValue(TextEditingValue oldValue, TextEditingValue newValue) {
    return _decimalFormatter.formatEditUpdate(oldValue, newValue);
  }

  bool _isUserInput(String s) {
    return s == _decimalSeparator || _decimalRegex.firstMatch(s) != null;
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty || newValue.text.trim() == (formatter ?? _formatter).symbols.PERCENT) {
      return newValue.copyWith(text: '');
    }
    String numValueStr = newValue.text.replaceAll((formatter ?? _formatter).symbols.PERCENT, "");
    String numberConverted = "";
    if (allowFraction) {
      numberConverted = numValueStr;
      if (_decimalSeparator != '.') {
        numberConverted = numValueStr.replaceFirst(RegExp(_decimalSeparator), '.');
      }
    }

    if ((double.tryParse(numberConverted) ?? 999) > 100) {
      return oldValue;
    }

    /// nothing changes, nothing to do
    if (newValue.text == _lastNewValue?.text) {
      return newValue;
    }
    String newString = newValue.text.replaceAll((formatter ?? _formatter).symbols.PERCENT, "");
    if (newValue.text.endsWith((formatter ?? _formatter).symbols.PERCENT)) {
      newValue = newValue.copyWith(
        text: newString,
        selection: TextSelection.collapsed(offset: newValue.selection.end),
      );
    }
    if (allowFraction &&
        newValue.text.contains((formatter ?? _formatter).symbols.DECIMAL_SEP) &&
        (newValue.text.split((formatter ?? _formatter).symbols.DECIMAL_SEP).last.length > 3 ||
            newValue.text.split((formatter ?? _formatter).symbols.DECIMAL_SEP).length >= 3)) {
      return oldValue;
    }
    _lastNewValue = newValue;

    /// remove all invalid characters
    newValue = _formatValue(oldValue, newValue);

    /// current selection
    int selectionIndex = newValue.selection.end;

    /// format original string, this step would add some separator
    /// characters to original string
    final newText = _formatPattern(newValue.text);

    /// count number of inserted character in new string
    int insertCount = 0;

    /// count number of original input character in new string
    int inputCount = 0;
    for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
      final character = newText[i];
      if (_isUserInput(character)) {
        inputCount++;
      } else {
        insertCount++;
      }
    }

    /// adjust selection according to number of inserted characters staying before
    /// selection
    selectionIndex += insertCount;
    selectionIndex = min(selectionIndex, newText.length);

    /// if selection is right after an inserted character, it should be moved
    /// backward, this adjustment prevents an issue that user cannot delete
    /// characters when cursor stands right after inserted characters
    if (selectionIndex - 1 >= 0 && selectionIndex - 1 < newText.length && !_isUserInput(newText[selectionIndex - 1])) {
      selectionIndex--;
    }

    return newValue.copyWith(
        text: newText + (formatter ?? _formatter).symbols.PERCENT,
        selection: TextSelection.collapsed(offset: selectionIndex),
        composing: TextRange.empty);
  }
}
