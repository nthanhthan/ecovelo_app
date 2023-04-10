import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class BottomSheetActions extends StatelessWidget {
  final Widget bodyContent;
  final String title;
  const BottomSheetActions({Key? key, required this.bodyContent, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 4,
            width: 50,
            margin: const EdgeInsets.all(AppProperties.itemSpace),
            decoration: BoxDecoration(
              color: AppColors.main.shade300,
              borderRadius: BorderRadius.circular(AppProperties.circleRadius),
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline4?.apply(color: AppColors.main),
        ),
        const Space(value: AppProperties.contentMargin),
        bodyContent,
      ],
    );
  }
}
