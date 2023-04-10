import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ecoveloapp/app/core.dart';



class CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final BuildContext buildContext;
  double currentSliderValue;
  CircleThumbShape({
    required this.buildContext,
    this.thumbRadius = 6.0,
    required this.currentSliderValue,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final double r = thumbRadius / 2;
    final Canvas canvas = context.canvas;
    final pointA = Offset(0, r);
    final pointB = Offset(
      r * sin(90.toRadian()),
      -r * cos(90.toRadian()),
    );
    final pointC = Offset(pointA.dx, -pointA.dy);

    final lineArrow = Path()
      ..moveTo(pointA.dx, pointA.dy)
      ..lineTo(pointB.dx, pointB.dy)
      ..lineTo(pointC.dx, pointC.dy);

    final Paint whitePaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final borderPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    String value = (currentSliderValue).toStringAsFixed(1);
    if (value.contains(".0")) {
      value = value.replaceAll(".0", "");
    }
    TextSpan span = TextSpan(
      style: AppTextStyles.bodyMedium().copyWith(
        color: AppColors.main,
      ),
      text: value,
    );

    Size textSize =
        TextUtil.textSize(buildContext, value, AppTextStyles.bodyMedium());

    TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    final pointO = Offset(r / 2, 0);
    final pointI = Offset(center.dx, center.dy);
    final translationVector = pointI - pointO;
    final realPath = lineArrow.shift(translationVector);

    canvas.drawCircle(
      center,
      thumbRadius,
      borderPaint,
    );
    canvas.drawPath(
      realPath,
      whitePaint,
    );
    tp.paint(
      canvas,
      Offset(
        center.dx - textSize.width / 2.0,
        center.dy + r * 2,
      ),
    );
  }
}

extension NumberUtil on num {
  num toRadian() {
    return this * pi / 180;
  }
}
