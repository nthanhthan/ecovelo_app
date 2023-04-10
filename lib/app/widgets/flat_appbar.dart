import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class AppBarAction {
  Key? key;
  void Function()? onTap;
  void Function(Offset offset)? onTapDetail;
  IconData iconData;

  AppBarAction({
    Key? key,
    required this.iconData,
    this.onTap,
    this.onTapDetail,
  });
}

class FlatAppBar extends AppBar {
  FlatAppBar({
    Key? key,
    required String title,
    void Function()? onBack,
    List<AppBarAction>? actions,
    Widget? leadingCustom,
    double? leadingWidth,
  }) : super(
          key: key,
          title: Text(title),
          centerTitle: true,
          leading: leadingCustom ??
              AppBarActionItem(
                action: AppBarAction(
                  iconData: Icons.arrow_back_ios_new,
                  onTap: onBack ?? () => Get.back<void>(),
                ),
              ),
          actions: actions?.map((e) => AppBarActionItem(action: e)).toList(),
          leadingWidth: leadingWidth ?? AppProperties.appBarHeight,
        );
}

class AppBarActionItem extends StatelessWidget {
  const AppBarActionItem({Key? key, required this.action}) : super(key: key);
  final AppBarAction action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        action.onTap?.call();
        action.onTapDetail?.call(details.globalPosition);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
       decoration: BoxDecoration(
         color: AppColors.grey.shade500,
         shape: BoxShape.circle
       ),
        margin: const EdgeInsets.fromLTRB(0, 14, 12, 14),
        width: 44,
        height: 44,
        child: Icon(
          action.iconData,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
