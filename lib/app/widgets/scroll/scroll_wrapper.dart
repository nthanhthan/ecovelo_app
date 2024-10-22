import 'package:flutter/material.dart';

import '../../constants/defines.dart';

class ScrollWrapper extends StatelessWidget {
  const ScrollWrapper({
    Key? key,
    required this.child,
    this.mainAxisMargin,
    this.controller,
    this.thickness = 4,
    this.color,
    this.thumbVisibility = true,
  }) : super(key: key);

  final Widget child;
  final double? mainAxisMargin;
  final ScrollController? controller;
  final double thickness;
  final Color? color;
  final bool thumbVisibility;

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbVisibility: thumbVisibility,
      crossAxisMargin: 2,
      mainAxisMargin: mainAxisMargin ?? 0,
      thickness: thickness,
      radius: const Radius.circular(60),
      interactive: false,
      thumbColor: color ?? AppColors.main,
      controller: controller,
      child: child,
    );
  }
}
