import 'package:flutter/material.dart';
import 'dart:math' as math;

double deg2rad(double deg) => deg * math.pi / 180;

class CircularPainter extends CustomPainter {
  /// ring/border thickness, default  it will be 8px [borderThickness].
  final double borderThickness;
  final double progressValue;
  final LinearGradient gradientColor;

  CircularPainter({
    this.borderThickness = 8.0,
    required this.progressValue,
    required this.gradientColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    final rect =
        Rect.fromCenter(center: center, width: size.width, height: size.height);

    Paint paint = Paint()
      ..color = Colors.grey.withOpacity(.3)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness;

    //grey background
    canvas.drawArc(
      rect,
      deg2rad(0),
      deg2rad(360),
      false,
      paint,
    );

    Paint progressBarPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness
      ..shader = gradientColor.createShader(rect);
    canvas.drawArc(
      rect,
      deg2rad(-90),
      deg2rad(360 * progressValue),
      false,
      progressBarPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
