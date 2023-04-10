import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
class BottomSheetAction {
  Key? key;
  void Function() onTap;
  String label;

  BottomSheetAction({
    Key? key,
    this.label = "",
    required this.onTap,
  });
}

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    Key? key,
    this.title,
    this.onLongPressTitle,
    required this.actions,
    this.isCloseBottomSheetAfterActionSelected = false,
  }) : super(key: key);

  final String? title;
  final Function()? onLongPressTitle;
  final List<BottomSheetAction> actions;
  final bool isCloseBottomSheetAfterActionSelected;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (title != null) {
      widgets.add(InkWell(
        child: title != null ? _buildTitle(context) : null,
        onLongPress: BuildConfig().isDebug ? onLongPressTitle : null,
      ));
    }

    if (actions.isNotEmpty) {
      for (var e in actions) {
        widgets.add(Container(height: 1, color: AppColors.grey.shade100));
        widgets.add(
          _buildBottomSheetButton(
            context,
            key: e.key,
            title: e.label,
            onTap: e.onTap,
          ),
        );
      }
    }

    return DisableAccessibility(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppProperties.contentMargin,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: widgets,
                ),
              ),
              const Space(value: AppProperties.itemSpace),
              _buildBottomSheetButton(
                context,
                key: const ValueKey("cancel"),
                title: S.of(context).cancel,
                borderRadius: 10,
                textFontWeight: FontWeight.w700,
                onTap: () {
                  Get.back<void>();
                },
              ),
              const Space(value: AppProperties.itemSpace),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          title!,
          style: AppTextStyles.bodyRegular().copyWith(
            fontSize: 14,
            color: AppColors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetButton(
    BuildContext context, {
    Key? key,
    required String title,
    required Function() onTap,
    double? borderRadius,
    FontWeight? textFontWeight,
  }) {
    return MaterialWidget(
      key: key,
      onTap: () {
        if (isCloseBottomSheetAfterActionSelected) {
          Get.back<void>();
        }
        onTap.call();
      },
      color: Colors.white,
      borderRadius: borderRadius ?? 0,
      splashColor: AppColors.main.shade100,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.bodyRegular().copyWith(
              fontSize: 16,
              color: AppColors.main,
              fontWeight: textFontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
