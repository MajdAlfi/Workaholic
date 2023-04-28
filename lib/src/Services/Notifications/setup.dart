import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> setup() async {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const androidInitializationSetting =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosInitializationSetting = DarwinInitializationSettings();
  const initSettings = InitializationSettings(
      android: androidInitializationSetting, iOS: iosInitializationSetting);
  await _flutterLocalNotificationsPlugin.initialize(initSettings);
}
