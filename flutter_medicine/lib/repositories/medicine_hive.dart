import 'package:flutter_medicine/models/medicine.dart';
import 'package:flutter_medicine/models/medicine_history.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedicineHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Medicine>(MedicineAdapter());
    Hive.registerAdapter<MedicineHistory>(MedicineHistoryAdapter());

    await Hive.openBox<Medicine>(MedicineHiveBox.medicine);
    await Hive.openBox<MedicineHistory>(MedicineHiveBox.medicineHistory);
  }
}

class MedicineHiveBox {
  static const String medicine = 'medicine';
  static const String medicineHistory = 'medicine_history';
}
