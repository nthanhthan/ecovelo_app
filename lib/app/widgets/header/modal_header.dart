import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class ModalHeader extends StatelessWidget {
  const ModalHeader({
    Key? key,
    required this.title,
    this.subTitle,
    this.isShowBack = true,
    this.subTitleColor,
    this.onBackPressed,
    this.lineHeight,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final bool isShowBack;
  final Color? subTitleColor;
  final void Function()? onBackPressed;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowBack)
          ModalBackIconBtn(
            onPressed: onBackPressed ?? () => Get.back<void>(),
          ),
        Space(value: Get.width * .1),
        DisableAccessibility(
          child: Text(
            title,
            style: AppTextStyles.modalTitle(),
          ),
        ),
        const Space(value: 6),
        if (subTitle != null)
          Text(
            subTitle!,
            style: AppTextStyles.bodyRegular().copyWith(
              color: subTitleColor,
              fontSize: 16,
              height: lineHeight,
            ),
          ),
        if (subTitle != null) const Space(value: 24),
      ],
    );
  }
}
