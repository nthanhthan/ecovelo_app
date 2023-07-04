import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    _configureLocalTimeZone();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/logo_ecovelo');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future<void> scheduledNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    await initNotification();
   // tz.initializeTimeZones(); // Khởi tạo múi giờ
    final location = tz.local;
    final now = tz.TZDateTime.now(location);
    final scheduledDate = tz.TZDateTime(location, now.year, now.month, now.day,
        hour, minute); // Thời gian cụ thể mỗi ngày
    // ignore: prefer_const_declarations
    final androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'chat_ai',
      'chat_ai_name',
      channelDescription: 'chat_ai_des',
      importance: Importance.max,
      priority: Priority.high,
    );
    // ignore: prefer_const_constructors
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      matchDateTimeComponents:
          DateTimeComponents.time, // Chỉ định thời gian cụ thể mỗi ngày
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'It could be anything you pass',
    );
  }

  Future<void> cancelNotificationAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
