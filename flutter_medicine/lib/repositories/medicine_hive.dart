import 'package:flutter_medicine/models/medicine.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedicineHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Medicine>(MedicineAdapter());

    await Hive.openBox<Medicine>(MedicineHiveBox.medicine);
  }
}

class MedicineHiveBox {
  static const String medicine = 'medicine';
}
