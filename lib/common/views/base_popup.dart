import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class PopupAction {
  final Widget child;
  final void Function() onTab;

  PopupAction({required this.child, required this.onTab});
}

class BasePopup extends StatelessWidget {
  final Widget? header;
  final Widget title;
  final Widget body;
  final List<Widget> actions;
  final Axis axis;
  final double radius;
  final double contentPadding;
  final bool isSmallAlert;
  final TextAlign textAlign;
  final double actionsTopSpace;
  const BasePopup({
    Key? key,
    required this.title,
    required this.body,
    required this.actions,
    this.radius = 8,
    this.contentPadding = 18,
    this.axis = Axis.horizontal,
    this.isSmallAlert = false,
    this.header,
    this.textAlign = TextAlign.center,
    this.actionsTopSpace = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(contentPadding),
      backgroundColor: AppColors.popupColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: <Widget>[
          if (header != null) header!,
          if (header != null) SizedBox(height: contentPadding),
          title,
          SizedBox(height: contentPadding),
          isSmallAlert
              ? body
              : SizedBox(
                  width: double.maxFinite,
                  child: body,
                ),
          SizedBox(height: actionsTopSpace),
          // buttons
          axis == Axis.vertical
              ? IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: actions,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: actions,
                ),
        ],
      ),
    );
  }
}
