import 'package:flutter/material.dart';
import 'snack_bars.dart';

class LocalNotificationObserver extends RouteObserver {
  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    if (SnackBars.hasActiveNotifications()) {
      SnackBars.dismissAll();
    }
    super.didStartUserGesture(route, previousRoute);
  }
}
