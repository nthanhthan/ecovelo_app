import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class ModalBackIconBtn extends StatelessWidget {
  const ModalBackIconBtn({Key? key, this.onPressed}) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(99),
      child: const Icon(
        Icons.arrow_back,
        color: AppColors.black,
        size: 30,
      ),
    );
  }
}
