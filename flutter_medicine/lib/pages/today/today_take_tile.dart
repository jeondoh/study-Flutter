import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/medicine_constants.dart';
import 'package:flutter_medicine/components/page_route.dart';
import 'package:flutter_medicine/main.dart';
import 'package:flutter_medicine/models/medicine_alarm.dart';
import 'package:flutter_medicine/models/medicine_history.dart';
import 'package:flutter_medicine/pages/add_medicine/add_medicine_page.dart';
import 'package:flutter_medicine/pages/bottomSheet/more_action_bottomSheet.dart';
import 'package:flutter_medicine/pages/bottomSheet/time_setting_bottomSheet.dart';
import 'package:flutter_medicine/pages/today/image_detail_page.dart';
import 'package:intl/intl.dart';

class BeforeTakeTile extends StatelessWidget {
  const BeforeTakeTile({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Row(
      children: [
        MedicineImageButton(imagePath: medicineAlarm.imagePath),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("🕑 ${medicineAlarm.alarmTime}", style: textStyle),
              const SizedBox(height: 6),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: _buildTileBody(textStyle, context),
              ),
            ],
          ),
        ),
        _MoreButton(medicineAlarm: medicineAlarm),
      ],
    );
  }

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context) {
    return [
      Text(medicineAlarm.name, style: textStyle),
      _TitleActionButton(
        onTap: () {
          historyRepository.addHistory(MedicineHistory(
            medicineId: medicineAlarm.id,
            medicineKey: medicineAlarm.key,
            alarmTime: medicineAlarm.alarmTime,
            takeTime: DateTime.now(),
            imagePath: medicineAlarm.imagePath,
            name: medicineAlarm.name,
          ));
        },
        title: '지금',
      ),
      Text('|', style: textStyle),
      _TitleActionButton(
        onTap: () => _onPreviousTake(context),
        title: '아까',
      ),
      Text('먹었어요!', style: textStyle),
    ];
  }

  void _onPreviousTake(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          TimeSettingBottomSheet(initialTime: medicineAlarm.alarmTime),
    ).then(
      (takeDateTime) {
        if (takeDateTime == null || takeDateTime is! DateTime) {
          return;
        }
        historyRepository.addHistory(
          MedicineHistory(
            medicineId: medicineAlarm.id,
            medicineKey: medicineAlarm.key,
            alarmTime: medicineAlarm.alarmTime,
            takeTime: takeDateTime,
            imagePath: medicineAlarm.imagePath,
            name: medicineAlarm.name,
          ),
        );
      },
    );
  }
}

class AfterTakeTile extends StatelessWidget {
  const AfterTakeTile({
    Key? key,
    required this.medicineAlarm,
    required this.history,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;
  final MedicineHistory history;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Row(
      children: [
        Stack(
          children: [
            MedicineImageButton(imagePath: medicineAlarm.imagePath),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green.withOpacity(0.7),
              child: const Icon(
                CupertinoIcons.check_mark,
                color: Colors.white,
              ),
            )
          ],
        ),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTitleBody(context, textStyle),
          ),
        ),
        _MoreButton(medicineAlarm: medicineAlarm),
      ],
    );
  }

  List<Widget> _buildTitleBody(BuildContext context, TextStyle? textStyle) {
    return [
      Text.rich(
        TextSpan(
          text: "✅ ${medicineAlarm.alarmTime} -> ",
          style: textStyle,
          children: [
            TextSpan(
              text: takeTimeStr,
              style: textStyle?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      const SizedBox(height: 6),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(medicineAlarm.name, style: textStyle),
          _TitleActionButton(
            onTap: () => _onTap(context),
            title: DateFormat('HH시 mm분에').format(history.takeTime),
          ),
          Text('먹었어요!', style: textStyle),
        ],
      ),
    ];
  }

  String get takeTimeStr => DateFormat('HH:mm').format(history.takeTime);

  void _onTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TimeSettingBottomSheet(
        initialTime: takeTimeStr,
        submitTitle: '수정',
        bottomWidget: TextButton(
          onPressed: () {
            historyRepository.deleteHistory(history.key);
            Navigator.pop(context);
          },
          child: Text(
            '복약 시간을 지우고 싶어요.',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),
    ).then(
      (takeDateTime) {
        if (takeDateTime == null || takeDateTime is! DateTime) {
          return;
        }
        historyRepository.updateHistory(
          key: history.key,
          history: MedicineHistory(
            medicineId: medicineAlarm.id,
            medicineKey: medicineAlarm.key,
            alarmTime: medicineAlarm.alarmTime,
            takeTime: takeDateTime,
            imagePath: medicineAlarm.imagePath,
            name: medicineAlarm.name,
          ),
        );
      },
    );
  }
}

class MedicineImageButton extends StatelessWidget {
  const MedicineImageButton({Key? key, required this.imagePath})
      : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: imagePath == null
          ? null
          : () {
              Navigator.push(
                context,
                FadePageRoute(
                  page: ImageDetailPage(imagePath: imagePath!),
                ),
              );
            },
      child: CircleAvatar(
        radius: 40,
        foregroundImage: imagePath == null
            ? null
            : FileImage(
                File(imagePath!),
              ),
        child: imagePath == null ? const Icon(CupertinoIcons.alarm_fill) : null,
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton({Key? key, required this.medicineAlarm}) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => MoreActionButtonSheet(
            onPressedModify: () {
              Navigator.push(
                context,
                FadePageRoute(
                    page: AddMedicinePage(updateMedicineId: medicineAlarm.id)),
              ).then((_) => Navigator.maybePop(context));
            },
            onPressedDeleteOnlyMedicine: () {
              notification.deleteMultipleAlarm(alarmIds);
              medicineRepository.deleteMedicine(medicineAlarm.key);
              Navigator.pop(context);
            },
            onPressedDeleteAll: () {
              notification.deleteMultipleAlarm(alarmIds);
              historyRepository.deleteAllHistory(keys);
              medicineRepository.deleteMedicine(medicineAlarm.key);
              Navigator.pop(context);
            },
          ),
        );
      },
      child: const Icon(CupertinoIcons.ellipsis_vertical),
    );
  }

  List<String> get alarmIds {
    final medicine = medicineRepository.medicineBox.values
        .singleWhere((element) => element.id == medicineAlarm.id);
    final alarmIds = medicine.alarms
        .map((alarmStr) => notification.alarmId(medicineAlarm.id, alarmStr))
        .toList();
    return alarmIds;
  }

  Iterable<int> get keys {
    final histories = historyRepository.historyBox.values.where((history) =>
        history.medicineId == medicineAlarm.id &&
        history.medicineKey == medicineAlarm.key);
    return histories.map((e) => e.key as int);
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
