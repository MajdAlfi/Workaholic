import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';

class notiicationInIt {
  static final _notification = FlutterLocalNotificationsPlugin();
  static Future showNotification(
          {int id = 0,
          String? title,
          String? body,
          String? payload,
          required DateTime scheduledDate}) async =>
      _notification.zonedSchedule(id, title, body,
          TZDateTime.from(scheduledDate, local), const NotificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
}
