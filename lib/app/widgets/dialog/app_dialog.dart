import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static Future<T?> showDefault<T>(
    BuildContext context, {
    required Widget bottomSheetWidget,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => LimitedScaleFactor(
        child: bottomSheetWidget,
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
