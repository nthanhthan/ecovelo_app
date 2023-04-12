import 'package:flutter/material.dart';
import '../../core.dart';

enum SizeButtonType {
  small,
  medium,
  large,
  custom,
}

EdgeInsetsGeometry _getBtnPadding({
  SizeButtonType sizeType = SizeButtonType.large,
  EdgeInsetsGeometry? customPadding,
}) {
  EdgeInsetsGeometry padding;
  switch (sizeType) {
    case SizeButtonType.small:
      padding = AppProperties.defaultSmallButtonPadding;
      break;
    case SizeButtonType.medium:
      padding = AppProperties.defaultMediumButtonPadding;
      break;
    case SizeButtonType.large:
      padding = AppProperties.defaultButtonPadding;
      break;
    case SizeButtonType.custom:
      padding = customPadding ?? AppProperties.defaultButtonPadding;
      break;
  }
  return padding;
}

class FilledBtnStyle {
  static ButtonStyle enable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
    bool isFullWidth = false,
    Color? background,
    Size? fixedSize,
    MaterialTapTargetSize? tapTargetSize,
    double borderRadius = 30,
  }) {
    return ElevatedButton.styleFrom(
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: Size(isFullWidth ? Get.width : 48, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      primary: background ?? AppColors.main.shade200,
      splashFactory: NoSplash.splashFactory,
      fixedSize: fixedSize,
      tapTargetSize: tapTargetSize,
    );
  }

  static ButtonStyle disable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
    double borderRadius = 30,
  }) {
    return ElevatedButton.styleFrom(
      primary: AppColors.disableButtonBackground,
      onPrimary: AppColors.disableTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      splashFactory: NoSplash.splashFactory,
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
    );
  }
}

class ElevatedBtnStyle {
  static ButtonStyle enable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
    bool isFullWidth = false,
    Color? background,
    Size? fixedSize,
    MaterialTapTargetSize? tapTargetSize,
  }) {
    return ElevatedButton.styleFrom(
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: Size(isFullWidth ? Get.width : 48, 10),
      primary: background,
      fixedSize: fixedSize,
      tapTargetSize: tapTargetSize,
    );
  }

  static ButtonStyle disable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
  }) {
    return ElevatedButton.styleFrom(
      primary: AppColors.disableButtonBackground,
      onPrimary: AppColors.disableTextColor,
      splashFactory: NoSplash.splashFactory,
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
    );
  }

  static ButtonStyle warningEnable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
    Size? fixedSize,
  }) {
    return ElevatedButton.styleFrom(
      primary: AppColors.red[600],
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
      fixedSize: fixedSize,
    );
  }

  static ButtonStyle warningDisable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
  }) {
    return ElevatedButton.styleFrom(
      primary: AppColors.disableButtonBackground,
      onPrimary: AppColors.disableTextColor,
      splashFactory: NoSplash.splashFactory,
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
    );
  }

  static ButtonStyle actionEnable() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 26,
      ),
      minimumSize: const Size(48, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      primary: AppColors.main.shade300,
    );
  }
}

class OutlineButtonStyle {
  static ButtonStyle enable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
    bool isFullWidth = false,
    Color? background,
    Color? outlineColor,
    Size? fixedSize,
    MaterialTapTargetSize? tapTargetSize,
  }) {
    return OutlinedButton.styleFrom(
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: Size(isFullWidth ? Get.width : 48, 10),
      primary: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      side: outlineColor != null
          ? BorderSide(
              color: outlineColor,
              width: 1.0,
              style: BorderStyle.solid,
            )
          : null,
      fixedSize: fixedSize,
      tapTargetSize: tapTargetSize,
    );
  }

  static ButtonStyle disable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
  }) {
    return OutlinedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      primary: AppColors.disableTextColor,
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
      side: const BorderSide(
        color: AppColors.disableTextColor,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );
  }
}

class TextButtonBtnStyle {
  static ButtonStyle enable({
    SizeButtonType sizeType = SizeButtonType.large,
    bool isFullWidth = false,
    EdgeInsetsGeometry? customPadding,
  }) {
    return TextButton.styleFrom(
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: Size(isFullWidth ? Get.width : 48, 10),
    );
  }

  static ButtonStyle disable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
  }) {
    return TextButton.styleFrom(
      primary: AppColors.disableTextColor,
      splashFactory: NoSplash.splashFactory,
      shadowColor: Colors.transparent,
      onSurface: Colors.transparent,
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
    );
  }
}

class TextIconButtonBtnStyle {
  static ButtonStyle enable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
  }) {
    return TextButton.styleFrom(
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
    );
  }

  static ButtonStyle disable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
  }) {
    return TextButton.styleFrom(
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
      primary: AppColors.disableTextColor,
      splashFactory: NoSplash.splashFactory,
      shadowColor: Colors.transparent,
      onSurface: Colors.transparent,
    );
  }

  static ButtonStyle warningEnable({
    SizeButtonType sizeType = SizeButtonType.large,
    EdgeInsetsGeometry? customPadding,
  }) {
    return TextButton.styleFrom(
      primary: AppColors.red[600],
      padding: _getBtnPadding(customPadding: customPadding, sizeType: sizeType),
      minimumSize: const Size(48, 10),
    );
  }
}
