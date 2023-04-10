import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'disable_accessibility.dart';

class SnackBars {
  String? title;
  String message = "";
  FlushbarPosition? position = FlushbarPosition.BOTTOM;
  IconData? icon;
  Color? iconColor = Colors.green;
  Color? indicatorColor = Colors.green;
  Color? borderColor;
  double borderRadius;
  Color? messageColor;
  Color backgroundColor;
  bool shouldIconPulse;

  static final List<Flushbar> _activeNotices = <Flushbar>[];

  factory SnackBars.info({required String message, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
      message: message,
      position: position,
      icon: Icons.info_outline,
      iconColor: Colors.grey[600],
      indicatorColor: Colors.grey[600],
    );
  }

  factory SnackBars.error({required String message, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
      message: message,
      position: position,
      icon: Icons.error_outline_rounded,
      iconColor: Colors.red,
      indicatorColor: Colors.red,
    );
  }

  factory SnackBars.complete({required String message, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
      message: message,
      position: position,
      icon: Icons.check_circle_outline_rounded,
      iconColor: Colors.green,
      indicatorColor: Colors.green,
    );
  }

  factory SnackBars.warning({required String message, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
      message: message,
      position: position,
      icon: Icons.warning_rounded,
      iconColor: Colors.orange[300],
      indicatorColor: Colors.orange[300],
    );
  }

  factory SnackBars.notice({required String message, String? title, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
        title: title ?? "",
        message: message,
        position: position,
        icon: Icons.notifications_active_rounded,
        iconColor: Colors.green[300],
        indicatorColor: Colors.green[300]);
  }

  SnackBars({
    this.icon,
    this.iconColor,
    this.indicatorColor,
    required this.message,
    this.title,
    this.position,
    this.borderColor,
    this.borderRadius = 30,
    this.messageColor,
    this.backgroundColor = const Color(0xFF303030),
    this.shouldIconPulse = true,
  });

  Flushbar show({int duration = 3000, BuildContext? context}) {
    Flushbar flushbar = Flushbar<void>(
      message: message,
      messageText: LimitedScaleFactor(
        child: Text(
          message,
          style: TextStyle(color: messageColor),
        ),
      ),
      title: title,
      titleText: title != null
          ? LimitedScaleFactor(
              child: Text(
                title!,              
              ),
            )
          : null,
      icon: Icon(
        icon,
        size: 28.0,
        color: iconColor,
      ),
      duration: Duration(milliseconds: duration),
      animationDuration: const Duration(milliseconds: 700),
      //leftBarIndicatorColor: indicatorColor,
      flushbarPosition: position ?? FlushbarPosition.BOTTOM,
      borderRadius: BorderRadius.circular(borderRadius),
      borderColor: borderColor,
      messageColor: messageColor,
      margin: const EdgeInsets.all(8),
      backgroundColor: backgroundColor,
      shouldIconPulse: shouldIconPulse,
    );
    flushbar.show(context ?? Get.context!);
    _activeNotices.add(flushbar);
    return flushbar;
  }

  static bool hasActiveNotifications() {
    for (Flushbar<dynamic> noti in _activeNotices) {
      if (noti.isAppearing() || noti.isHiding() || noti.isShowing()) {
        return true;
      }
    }
    return false;
  }

  static void removeDimissedNotifications() {
    _activeNotices.removeWhere((element) => element.isDismissed());
  }

  static Future<void> dismissAll() async {
    removeDimissedNotifications();
    await Future.forEach(_activeNotices, (Flushbar<dynamic> noti) async {
      await noti.dismiss();
    });
  }
}
