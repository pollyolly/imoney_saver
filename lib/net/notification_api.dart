import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

//https://www.youtube.com/watch?v=bRy5dmts3X8

class NotificationApi {
  static final notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  static Future notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          "channel id",
          "channel name",
          // "channel description",
          importance: Importance.max,
          playSound: true,
        ),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await notification.initialize(settings,
        onSelectNotification: (payload) async {
      onNotification.add(payload!);
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      {
        notification.show(id, title, body, await notificationDetails(),
            payload: payload)
      };
}
