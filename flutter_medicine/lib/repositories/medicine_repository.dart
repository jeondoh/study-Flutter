import 'dart:developer';

import 'package:flutter_medicine/models/medicine.dart';
import 'package:flutter_medicine/repositories/medicine_hive.dart';
import 'package:hive/hive.dart';

class MedicineRepository {
  Box<Medicine>? _medicineBox;

  Box<Medicine> get medicineBox {
    _medicineBox ??= Hive.box<Medicine>(MedicineHiveBox.medicine);
    return _medicineBox!;
  }

  void addMedicine(Medicine medicine) async {
    int key = await medicineBox.add(medicine);

    log('[addMedicine] add {key:$key} $medicine');
    log('result ${medicineBox.values.toList()}');
  }

  void deleteMedicine(int key) async {
    await medicineBox.delete(key);

    log('[addMedicine] delete {key:$key}');
    log('result ${medicineBox.values.toList()}');
  }

  void updateMedicine({
    required int key,
    required Medicine medicine,
  }) async {
    await medicineBox.put(key, medicine);

    log('[addMedicine] update {key:$key} $medicine');
    log('result ${medicineBox.values.toList()}');
  }

  int get newId {
    return medicineBox.values.isEmpty ? 0 : medicineBox.values.last.id + 1;
  }
}
