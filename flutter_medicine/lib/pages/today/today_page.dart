import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/medicine_constants.dart';
import 'package:flutter_medicine/main.dart';
import 'package:flutter_medicine/models/medicine.dart';
import 'package:flutter_medicine/models/medicine_alarm.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "오늘 복용할 약은?",
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: regularSpace),
        const Divider(height: 1, thickness: 2.0),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: medicineRepository.medicineBox.listenable(),
            builder: _builderMedicineListView,
          ),
        ),
      ],
    );
  }

  Widget _builderMedicineListView(
    context,
    Box<Medicine> box,
    _,
  ) {
    final medicines = box.values.toList();
    final medicineAlarms = <MedicineAlarm>[];

    for (var medicine in medicines) {
      for (var alarm in medicine.alarms) {
        medicineAlarms.add(MedicineAlarm(
          medicine.id,
          medicine.name,
          medicine.imagePath,
          alarm,
          medicine.key,
        ));
      }
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: smallSpace),
      itemCount: medicineAlarms.length,
      itemBuilder: (context, index) {
        return _MedicineListTile(
          medicineAlarm: medicineAlarms[index],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(height: regularSpace);
      },
    );
  }
}

class _MedicineListTile extends StatelessWidget {
  const _MedicineListTile({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Container(
      child: Row(
        children: [
          CupertinoButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            child: CircleAvatar(
              radius: 40,
              foregroundImage: medicineAlarm.imagePath == null
                  ? null
                  : FileImage(
                      File(medicineAlarm.imagePath!),
                    ),
            ),
          ),
          const SizedBox(width: smallSpace),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("🕑 ${medicineAlarm.alarmTime}", style: textStyle),
                const SizedBox(height: 6),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(medicineAlarm.name, style: textStyle),
                    _TitleActionButton(
                      onTap: () {},
                      title: '지금',
                    ),
                    Text('|', style: textStyle),
                    _TitleActionButton(
                      onTap: () {},
                      title: '아까',
                    ),
                    Text('먹었어요!', style: textStyle),
                  ],
                ),
              ],
            ),
          ),
          CupertinoButton(
            onPressed: () {
              medicineRepository.deleteMedicine(medicineAlarm.key);
            },
            child: const Icon(CupertinoIcons.ellipsis_vertical),
          ),
        ],
      ),
    );
  }
}

class _TitleActionButton extends StatelessWidget {
  const _TitleActionButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontWeight: FontWeight.w500);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}

class _BuilderMedicineListView extends StatelessWidget {
  const _BuilderMedicineListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
