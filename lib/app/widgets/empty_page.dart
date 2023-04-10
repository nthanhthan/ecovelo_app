import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class EmptyPage extends StatelessWidget {
  final String placeholderText;
  final Widget? placeholderWidget;
  final Widget? bottomBodyWidget;
  final IconData? placeholderIcon;
  final Color? placeholderColor;
  final bool isExpaded;

  const EmptyPage({
    Key? key,
    this.placeholderText = "",
    this.placeholderWidget,
    this.placeholderColor,
    this.placeholderIcon,
    this.bottomBodyWidget,
    this.isExpaded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget placeholder;
    Color phColor = Theme.of(context).primaryColor.withAlpha(120);
    if (placeholderColor != null) {
      phColor = placeholderColor!;
    }
    if (placeholderWidget == null) {
      placeholder = Icon(
        placeholderIcon ?? Icons.nearby_error,
        size: Get.width * .35,
        color: phColor,
      );
    } else {
      placeholder = placeholderWidget!;
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isExpaded) const Expanded(child: SizedBox.shrink()),
          placeholder,
          const SizedBox(height: 28),
          Text(
            placeholderText,
            style: TextStyle(
              color: phColor,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          if (bottomBodyWidget != null) bottomBodyWidget!,
          if (isExpaded) const Expanded(flex: 2, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
