import 'dart:developer';

import 'package:flutter_medicine/models/medicine_history.dart';
import 'package:flutter_medicine/repositories/medicine_hive.dart';
import 'package:hive/hive.dart';

class MedicineHistoryRepository {
  Box<MedicineHistory>? _historyBox;

  Box<MedicineHistory> get historyBox {
    _historyBox ??= Hive.box<MedicineHistory>(MedicineHiveBox.medicineHistory);
    return _historyBox!;
  }

  void addHistory(MedicineHistory history) async {
    int key = await historyBox.add(history);

    log('[addHistory] add {key:$key} $history');
    log('result ${historyBox.values.toList()}');
  }

  void deleteHistory(int key) async {
    await historyBox.delete(key);

    log('[deleteHistory] delete {key:$key}');
    log('result ${historyBox.values.toList()}');
  }

  void deleteAllHistory(Iterable<int> keys) async {
    await historyBox.deleteAll(keys);

    log('[deleteAllHistory] delete {keys:$keys}');
    log('result ${historyBox.values.toList()}');
  }

  void updateHistory({
    required int key,
    required MedicineHistory history,
  }) async {
    await historyBox.put(key, history);

    log('[updateHistory] update {key:$key} $history');
    log('result ${historyBox.values.toList()}');
  }
}
