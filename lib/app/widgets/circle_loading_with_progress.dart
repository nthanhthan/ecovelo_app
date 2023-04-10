import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class CircleLoadingWithProgress extends StatelessWidget {
  const CircleLoadingWithProgress({
    Key? key,
    this.barColor = AppColors.white,
    this.bgColor,
    this.progress = 0,
  }) : super(key: key);

  final Color barColor;
  final Color? bgColor;
  final double progress;

  @override
  Widget build(BuildContext context) {
    double? progressVal;
    if (progress > 0 && progress < 1) {
      progressVal = progress;
    }
    return CircularProgressIndicator(
      value: progressVal,
      color: barColor,
      backgroundColor: bgColor ?? AppColors.grey.shade300,
    );
  }
}
