import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/medicine_constants.dart';
import 'package:flutter_medicine/main.dart';
import 'package:flutter_medicine/models/medicine.dart';
import 'package:flutter_medicine/models/medicine_history.dart';
import 'package:flutter_medicine/pages/today/today_take_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '잘 복용 했어요 👏🏻',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: regularSpace),
        const Divider(height: 1, thickness: 1.0),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: historyRepository.medicineBox.listenable(),
            builder: _buildListView,
          ),
        ),
      ],
    );
  }

  Widget _buildListView(context, Box<MedicineHistory> historyBox, _) {
    final histories = historyBox.values.toList().reversed.toList();
    return ListView.builder(
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final history = histories[index];
        return _TimeTile(history: history);
      },
    );
  }
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({Key? key, required this.history}) : super(key: key);

  final MedicineHistory history;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            DateFormat('yyyy\nMM.dd E', 'ko_KR').format(history.takeTime),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  height: 1.6,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
          ),
        ),
        Stack(
          alignment: const Alignment(0.0, -0.2),
          children: const [
            SizedBox(
              height: 130,
              child: VerticalDivider(
                width: 1,
                thickness: 1,
              ),
            ),
            CircleAvatar(
              radius: 4,
              child: CircleAvatar(
                radius: 3,
                backgroundColor: Colors.white,
              ),
            )
          ],
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: medicine.imagePath != null,
                child: MedicineImageButton(imagePath: medicine.imagePath),
              ),
              const SizedBox(width: smallSpace),
              Text(
                '${DateFormat('a hh:mm', 'ko_KR').format(history.takeTime)}\n${medicine.name}',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      height: 1.6,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Medicine get medicine {
    return medicineRepository.medicineBox.values.singleWhere(
      (element) =>
          element.id == history.medicineId &&
          element.key == history.medicineKey,
      orElse: () =>
          Medicine(imagePath: null, alarms: [], id: -1, name: '삭제된 약입니다.'),
    );
  }
}
