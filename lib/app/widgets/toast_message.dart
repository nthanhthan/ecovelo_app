import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ecoveloapp/app/core.dart';


class ToastMessage {
  final SnackBars snackBars;
  ToastMessage(this.snackBars);

  factory ToastMessage.complete({
    required String message,
    FlushbarPosition position = FlushbarPosition.TOP,
  }) {
    return ToastMessage(
      SnackBars(
        icon: Icons.check_circle_outline_rounded,
        iconColor: AppColors.grey,
        message: message,
        messageColor: AppColors.grey,
        borderColor: AppColors.main,
        borderRadius: AppProperties.circleRadius,
        position: position,
        backgroundColor: AppColors.white,
        shouldIconPulse: false,
      ),
    );
  }

  factory ToastMessage.error({
    required String message,
    FlushbarPosition position = FlushbarPosition.TOP,
  }) {
    return ToastMessage(
      SnackBars(
        icon: Icons.error_outline,
        iconColor: AppColors.red.shade600,
        message: message,
        messageColor: AppColors.grey,
        borderColor: AppColors.main,
        borderRadius: AppProperties.circleRadius,
        position: position,
        backgroundColor: AppColors.white,
        shouldIconPulse: false,
      ),
    );
  }

  factory ToastMessage.info({
    required String message,
    FlushbarPosition position = FlushbarPosition.TOP,
  }) {
    return ToastMessage(
      SnackBars(
        icon: Icons.error_outline_rounded,
        iconColor: AppColors.main,
        message: message,
        messageColor: AppColors.grey,
        borderColor: AppColors.main,
        borderRadius: AppProperties.circleRadius,
        position: position,
        backgroundColor: AppColors.white,
        shouldIconPulse: false,
      ),
    );
  }

  void show({int duration = 3000, BuildContext? context}) {
    snackBars.show(duration: duration, context: context);
  }
}
