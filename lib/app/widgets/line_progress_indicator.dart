import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class LineInprogressIndicator extends StatelessWidget {
  const LineInprogressIndicator({
    Key? key,
    this.isEnabled = true,
    this.padding = const EdgeInsets.only(bottom: 2.0),
  }) : super(key: key);

  final bool isEnabled;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    double progressHeight = 0.1;
    if (isEnabled){
      progressHeight = padding.bottom + padding.top + 2;
    }
    return AnimatedContainer(
      duration: AppProperties.defaultAnimatedDuration,
      height: progressHeight,
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: progressHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: progressHeight,
              color: AppColors.main.shade400,
              backgroundColor: AppColors.grey.shade200,
            ),
          ),
        ),
      ),
    );
  }
}
