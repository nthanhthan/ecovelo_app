import 'package:flutter/cupertino.dart';
import '../../core.dart';

class AppTextStyles {
  static TextStyle lead() {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 80,
      color: AppColors.black,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle subLead() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      color: AppColors.black,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle body1() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: AppColors.defaultTextColor,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle body2() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: AppColors.white,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle bodyMedium() {
    return const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.defaultTextColor,
    );
  }

  static TextStyle largeHeading1() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 40,
      color: AppColors.defaultTextColor,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle largeHeading2() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 32,
      color: AppColors.defaultTextColor,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle heading1() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: AppColors.defaultTextColor,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle heading2() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: AppColors.defaultTextColor,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle bodyRegular() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.defaultTextColor,
    );
  }

  static TextStyle capitalized() {
    return const TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: AppColors.defaultTextColor,
    );
  }

  static TextStyle title() {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 44,
      color: AppColors.defaultTextColor,
    );
  }

  static TextStyle small() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      color: AppColors.defaultTextColor,
    );
  }

  static TextStyle tiny() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColors.defaultTextColor,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle label() {
    return const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 8,
      color: AppColors.defaultTextColor,
    );
  }

  static TextStyle overline12() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColors.defaultTextColor,
    );
  }

  static TextStyle button() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle textButton() {
    return const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle modalTitle() {
    return const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    );
  }

  static TextStyle big() {
    return const TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 18,
      fontFamily: AppProperties.fontFamilyName,
    );
  }

  static TextStyle subHeading1() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: AppColors.defaultTextColor,
      fontFamily: AppProperties.fontFamilyName,
    );
  }
}
