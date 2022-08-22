import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/medicine_themes.dart';
import 'package:flutter_medicine/repositories/medicine_hive.dart';
import 'package:flutter_medicine/repositories/medicine_repository.dart';
import 'package:flutter_medicine/services/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'pages/home_page.dart';
import 'repositories/medicine_history_repository.dart';

final notification = NotificationService();
final hive = MedicineHive();
final medicineRepository = MedicineRepository();
final historyRepository = MedicineHistoryRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  await notification.initializeTimeZone();
  await notification.initializeNotification();

  await hive.initializeHive();

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
