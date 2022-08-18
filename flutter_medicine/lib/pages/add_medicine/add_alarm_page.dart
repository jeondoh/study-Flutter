import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/common_widgets.dart';
import 'package:flutter_medicine/components/medicine_colors.dart';
import 'package:flutter_medicine/components/medicine_constants.dart';
import 'package:flutter_medicine/main.dart';
import 'package:flutter_medicine/models/medicine.dart';
import 'package:flutter_medicine/pages/add_medicine/components/add_page_widget.dart';
import 'package:flutter_medicine/services/add_medicine_service.dart';
import 'package:flutter_medicine/services/file_service.dart';
import 'package:intl/intl.dart';

class AddAlarmPage extends StatelessWidget {
  AddAlarmPage(
      {Key? key, required this.medicineImage, required this.medicineName})
      : super(key: key);

  final File? medicineImage;
  final String medicineName;
  final service = AddMedicineService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddPageBody(
        children: [
          Text(
            '매일 복약 잊지 말아요!',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: largeSpace),
          Expanded(
            child: AnimatedBuilder(
              builder: (context, _) {
                return ListView(
                  children: alarmWidgets,
                );
              },
              animation: service,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: () async {
          for (var alarm in service.alarms) {
            final result = await notification.addNotification(
              medicineId: medicineRepository.newId,
              alarmTimeStr: alarm,
              title: '$alarm 약 먹을 시간이에요!',
              body: '$medicineName 복약했다고 알려주세요!',
            );
            if (!result) {
              return showPermissionDenied(context, permission: '알람');
            }
          }
          String? imageFilePath;
          if (medicineImage != null) {
            imageFilePath = await saveImageToLocalDirectory(medicineImage!);
          }

          final medicine = Medicine(
            id: medicineRepository.newId,
            name: medicineName,
            imagePath: imageFilePath,
            alarms: service.alarms.toList(),
          );
          medicineRepository.addMedicine(medicine);
          // 팝업 전체 종료
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        text: '완료',
      ),
    );
  }

  List<Widget> get alarmWidgets {
    final children = <Widget>[];
    children.addAll(
      service.alarms.map(
        (alarmTime) => _AlarmBox(
          time: alarmTime,
          service: service,
        ),
      ),
    );
    children.add(_AddAlarmButton(service: service));
    return children;
  }
}

class _AlarmBox extends StatelessWidget {
  const _AlarmBox({Key? key, required this.time, required this.service})
      : super(key: key);

  final String time;
  final AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {
              service.removeAlarm(time);
            },
            icon: const Icon(CupertinoIcons.minus_circle),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return _TimePickerBottomSheet(
                    initalTime: time,
                    service: service,
                  );
                },
              );
            },
            child: Text(time),
          ),
        )
      ],
    );
  }
}

class _TimePickerBottomSheet extends StatelessWidget {
  _TimePickerBottomSheet(
      {Key? key, required this.initalTime, required this.service})
      : super(key: key);

  final String initalTime;
  final AddMedicineService service;
  DateTime? _setDateTime;

  @override
  Widget build(BuildContext context) {
    final initalDateTime = DateFormat('HH:mm').parse(initalTime);

    return BottomSheetBody(
      children: [
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {
              _setDateTime = dateTime;
            },
            mode: CupertinoDatePickerMode.time,
            initialDateTime: initalDateTime,
          ),
        ),
        const SizedBox(height: regularSpace),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.subtitle1,
                    primary: Colors.white,
                    onPrimary: MedicineColors.primaryColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
              ),
            ),
            const SizedBox(width: smallSpace),
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                  onPressed: () {
                    service.setAlarm(
                      prevTime: initalTime,
                      setTime: _setDateTime ?? initalDateTime,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('선택'),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class _AddAlarmButton extends StatelessWidget {
  const _AddAlarmButton({Key? key, required this.service}) : super(key: key);

  final AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        textStyle: Theme.of(context).textTheme.subtitle1,
      ),
      onPressed: service.addNowAlarm,
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: Icon(CupertinoIcons.plus_circle_fill),
          ),
          Expanded(
            flex: 5,
            child: Center(child: Text("복용시간 추가")),
          )
        ],
      ),
    );
  }
}
