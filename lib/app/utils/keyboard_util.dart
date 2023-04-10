import 'package:flutter/material.dart';

class KeyboardUtil {
  static void dismissKeyboard(BuildContext context) {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    } else if (currentScope.hasFocus) {
      currentScope.unfocus();
    }
  }
}
