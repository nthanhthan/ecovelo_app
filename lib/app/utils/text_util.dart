import 'package:flutter/material.dart';

import '../core.dart';

class TextUtil {
  static Size textSize(BuildContext context, String text, TextStyle style) {
    double scaleFactor = MediaQuery.of(context).textScaleFactor;
    if (scaleFactor > maxTextScaleFactorDef) {
      scaleFactor = maxTextScaleFactorDef;
    }
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textScaleFactor: scaleFactor,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
