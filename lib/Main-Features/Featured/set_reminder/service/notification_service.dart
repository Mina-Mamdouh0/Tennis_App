import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('app_icon.jpg');

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription:
            'channel description', // Specify the name for channel description
        importance: Importance.max,
        icon: "app_icon", //<-- Add this parameter
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notification.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static void showSchaduleNotification(
          {int id = 0,
          String? title,
          String? body,
          String? payload,
          DateTime? scheduleDate}) async =>
      _notification.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduleDate!, tz.local),
          await _notificationDetails(),
          payload: payload,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
}
