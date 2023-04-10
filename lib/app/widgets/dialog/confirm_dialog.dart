import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Widget? header;
  final String title;
  final TextStyle? titleTextStyle;
  final String message;
  final String denyText;
  final String approveText;
  final Function? onApproval;
  final Function? onDenial;
  final bool isReversedApproveToRightPosition;
  final Color? denyTextColor;
  final Color? approveColor;
  final bool isHideCancelButton;
  final TextAlign messageAlignment;
  final Axis buttonAxis;
  final bool isButtonFullWidth;
  final EdgeInsetsGeometry acctionPadding;

  const ConfirmDialog({
    Key? key,
    this.title = "",
    this.titleTextStyle,
    this.header,
    this.message = "",
    this.denyText = "Cancel",
    this.approveText = "Yes",
    this.onApproval,
    this.onDenial,
    this.isReversedApproveToRightPosition = false,
    this.approveColor,
    this.denyTextColor,
    this.isHideCancelButton = false,
    this.messageAlignment = TextAlign.center,
    this.buttonAxis = Axis.horizontal,
    this.isButtonFullWidth = false,
    this.acctionPadding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> actionWidgets = <Widget>[];

    actionWidgets.add(Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onApproval?.call();
          },
          child: Padding(
            padding: acctionPadding,
            child: Text(approveText),
          ),
          style: ElevatedBtnStyle.enable(
            background: approveColor,
            isFullWidth: isButtonFullWidth,
          ),
        ),
      ),
    ));

    if (!isHideCancelButton) {
      actionWidgets.add(Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDenial?.call();
            },
            child: Padding(
              padding: acctionPadding,
              child: Text(
                denyText,
                style: denyTextColor == null
                    ? null
                    : AppTextStyles.button().copyWith(
                        color: denyTextColor,
                      ),
              ),
            ),
            style: ElevatedBtnStyle.enable(
              isFullWidth: isButtonFullWidth,
              background: AppColors.popupColor,
            ),
          ),
        ),
      ));
    }

    if (isReversedApproveToRightPosition) {
      actionWidgets = actionWidgets.reversed.toList();
    }

    return LimitedScaleFactor(
      child: BasePopup(
        radius: AppProperties.dialogCircleRadius,
        isSmallAlert: true,
        header: header,
        contentPadding: AppProperties.contentMargin,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppProperties.contentMargin,
          ),
          child: Text(
            title,
            style: AppTextStyles.heading2().copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: message.isNotEmpty
            ? Text(
                message,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: messageAlignment,
              )
            : const SizedBox(),
        actions: actionWidgets,
        axis: buttonAxis,
      ),
    );
  }
}
