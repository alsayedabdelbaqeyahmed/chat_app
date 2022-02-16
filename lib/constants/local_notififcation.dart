import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static void starting() {
    final InitializationSettings setting = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationPlugin.initialize(setting);
  }

  static void display(RemoteMessage messege) async {
    try {
      final id = Timestamp.now().seconds;
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "sayed",
          "sayed channel",
          channelDescription: "this is my channel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      );

      _notificationPlugin.show(id, messege.notification!.title,
          messege.notification!.body, notificationDetails);
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
