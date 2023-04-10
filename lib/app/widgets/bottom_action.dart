import 'package:flutter/material.dart';
import 'package:ecoveloapp/app/core.dart';


class BtmActionItem {
  String label;
  Widget? icon;
  bool isOutline;
  bool iconAlignToRight;
  bool isEnabled;
  final void Function()? onPress;

  BtmActionItem({
    this.icon,
    this.iconAlignToRight = false,
    this.isOutline = false,
    this.isEnabled = true,
    required this.label,
    this.onPress,
  });
}

class BottomAction extends StatelessWidget {
  const BottomAction({
    Key? key,
    this.isEnable = true,
    this.isExpanded = true,
    this.height = 48,
    this.actionBtnWidth,
    this.backgroundColor = AppColors.white,
    this.pading = const EdgeInsets.fromLTRB(20, 8, 20, 8),
    required this.actionItems,
  }) : super(key: key);

  final bool isEnable;
  final bool isExpanded;
  final double height;
  final double? actionBtnWidth;
  final Color backgroundColor;
  final List<BtmActionItem> actionItems;
  final EdgeInsets pading;

  @override
  Widget build(BuildContext context) {
    return DisableAccessibility(
      child: IgnorePointer(
        ignoring: !isEnable,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.04),
                spreadRadius: 20,
                blurRadius: 7,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: pading,
          child: SafeArea(
            child: isExpanded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: actionItems.map<Widget>((item) {
                      Widget action = (item.isOutline)
                          ? _buildActionOutlineItem(context, item)
                          : _buildActionItem(context, item);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppProperties.lineSpace),
                          child: action,
                        ),
                      );
                    }).toList(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: actionItems.map<Widget>((item) {
                      Widget action = (item.isOutline)
                          ? _buildActionOutlineItem(context, item)
                          : _buildActionItem(context, item);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppProperties.lineSpace),
                        child: action,
                      );
                    }).toList(),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, BtmActionItem action) {
    ButtonStyle btnStyle =
        ElevatedBtnStyle.enable(sizeType: SizeButtonType.medium);
    if (!action.isEnabled) {
      btnStyle = ElevatedButton.styleFrom(
        onPrimary: AppColors.main.shade400,
        onSurface: AppColors.main,
        minimumSize: const Size(48, 10),
        padding: AppProperties.defaultMediumButtonPadding,
      );
    }

    return ElevatedButton(
      onPressed: action.isEnabled ? action.onPress : null,
      style: btnStyle,
      child: _buildActionItemContent(context, action),
    );
  }

  Widget _buildActionOutlineItem(BuildContext context, BtmActionItem action) {
    ButtonStyle btnStyle = action.isEnabled
        ? OutlineButtonStyle.enable(sizeType: SizeButtonType.medium)
        : OutlineButtonStyle.disable(sizeType: SizeButtonType.medium);

    return OutlinedButton(
      onPressed: action.isEnabled ? action.onPress : null,
      style: btnStyle,
      child: _buildActionItemContent(context, action),
    );
  }

  Widget _buildActionItemContent(BuildContext context, BtmActionItem action) {
    bool iconRight = action.iconAlignToRight && action.icon != null;
    bool iconLeft = !action.iconAlignToRight && action.icon != null;
    return SizedBox(
      height: height,
      width: actionBtnWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconLeft) action.icon!,
          if (iconLeft) const Space(direction: Axis.horizontal),
          Flexible(
            child: Text(
              action.label,
              maxLines: 1,
            ),
          ),
          if (iconRight) const Space(direction: Axis.horizontal),
          if (iconRight) action.icon!,
        ],
      ),
    );
  }
}
