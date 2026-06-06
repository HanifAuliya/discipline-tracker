import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await notifications.initialize(settings);

    tz.initializeTimeZones();
    debugPrint("Timezone aktif: ${tz.local.name}");

    await notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
  }

  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'discipline_channel',
      'Discipline Tracker',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await notifications.show(0, title, body, details);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'discipline_channel',
      'Discipline Tracker',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    debugPrint("Schedule untuk: $scheduledTime");

    try {
      await notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(
          tz.local,
        ).add(scheduledTime.difference(DateTime.now())),
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.inexact,
      );

      debugPrint("Schedule berhasil dibuat");

      final pending = await notifications.pendingNotificationRequests();
      debugPrint("Pending: ${pending.length}");
    } catch (e) {
      debugPrint("ERROR SCHEDULE: $e");
    }
  }
}
