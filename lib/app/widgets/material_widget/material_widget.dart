import 'package:flutter/material.dart';
import '../../core.dart';

class MaterialWidget extends StatelessWidget {
  const MaterialWidget({
    Key? key,
    required this.onTap,
    required this.child,
    this.color,
    this.borderRadius = 0,
    this.splashColor,
  }) : super(key: key);

  final Function? onTap;
  final double borderRadius;
  final Color? color;
  final Widget child;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap != null ? () => onTap?.call() : null,
        child: child,
        splashColor: splashColor ?? AppColors.grey.shade100,
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(borderRadius),
        highlightColor: Colors.transparent,
      ),
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}
