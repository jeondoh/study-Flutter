import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:widget_study/pages/my_home_page.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initTimezoneSetting();
  _initNotiSetting();
  runApp(const MyApp());
}

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void _initTimezoneSetting() async {
  tz.initializeTimeZones();
  // 국가/지역 받오기
  final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

void _initNotiSetting() async {
  const initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}
