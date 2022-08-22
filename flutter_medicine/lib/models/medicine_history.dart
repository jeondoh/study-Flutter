import 'package:hive/hive.dart';

part 'medicine_history.g.dart';

// flutter packages pub run build_runner build
@HiveType(typeId: 2)
class MedicineHistory extends HiveObject {
  MedicineHistory({
    required this.medicineId,
    required this.medicineKey,
    required this.alarmTime,
    required this.takeTime,
    required this.name,
    required this.imagePath,
  });

  @HiveField(0)
  final int medicineId;

  @HiveField(1)
  final String alarmTime;

  @HiveField(2)
  final DateTime takeTime;

  @HiveField(3, defaultValue: -1)
  final int medicineKey;

  @HiveField(4, defaultValue: '삭제된 약')
  final String name;

  @HiveField(5)
  final String? imagePath;

  @override
  String toString() {
    return '{medicineId: $medicineId, medicineKey: $medicineKey, alarmTime: $alarmTime, takeTime: $takeTime, name: $name, imagePath: $imagePath}';
  }
}
