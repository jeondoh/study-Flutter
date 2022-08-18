import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/medicine_themes.dart';
import 'package:flutter_medicine/services/notification_service.dart';

import 'pages/home_page.dart';

final notification = NotificationService();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  notification.initializeTimeZone();
  notification.initializeNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MedicineThemes.lightTheme,
      home: const HomePage(),
      builder: (context, child) => MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
    );
  }
}
