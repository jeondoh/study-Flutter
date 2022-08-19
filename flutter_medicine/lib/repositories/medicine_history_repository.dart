import 'dart:developer';

import 'package:flutter_medicine/models/medicine_history.dart';
import 'package:flutter_medicine/repositories/medicine_hive.dart';
import 'package:hive/hive.dart';

class MedicineHistoryRepository {
  Box<MedicineHistory>? _historyBox;

  Box<MedicineHistory> get medicineBox {
    _historyBox ??= Hive.box<MedicineHistory>(MedicineHiveBox.medicineHistory);
    return _historyBox!;
  }

  void addHistory(MedicineHistory history) async {
    int key = await medicineBox.add(history);

    log('[addHistory] add {key:$key} $history');
    log('result ${medicineBox.values.toList()}');
  }

  void deleteHistory(int key) async {
    await medicineBox.delete(key);

    log('[deleteHistory] delete {key:$key}');
    log('result ${medicineBox.values.toList()}');
  }

  void updateHistory({
    required int key,
    required MedicineHistory history,
  }) async {
    await medicineBox.put(key, history);

    log('[updateHistory] update {key:$key} $history');
    log('result ${medicineBox.values.toList()}');
  }
}
