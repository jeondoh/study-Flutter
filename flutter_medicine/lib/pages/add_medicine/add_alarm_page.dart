import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/common_widgets.dart';
import 'package:flutter_medicine/components/medicine_colors.dart';
import 'package:flutter_medicine/components/medicine_constants.dart';
import 'package:flutter_medicine/pages/add_medicine/components/add_page_widget.dart';
import 'package:intl/intl.dart';

class AddAlarmPage extends StatefulWidget {
  AddAlarmPage(
      {Key? key, required this.medicineImage, required this.medicineName})
      : super(key: key);

  final File? medicineImage;
  final String medicineName;

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  final _alarms = <String>{
    '08:00',
    '13:00',
    '20:00',
  };

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
            child: ListView(
              children: alarmWidgets,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: () {},
        text: '완료',
      ),
    );
  }

  List<Widget> get alarmWidgets {
    final children = <Widget>[];
    children.addAll(
      _alarms.map(
        (alarmTime) => _AlarmBox(
          time: alarmTime,
          onPressedMinus: () {
            setState(() {
              _alarms.remove(alarmTime);
            });
          },
        ),
      ),
    );
    children.add(_AddAlarmButton(
      onPressed: () {
        final now = DateTime.now();
        final nowTime = DateFormat('HH:mm').format(now);
        setState(() {
          _alarms.add(nowTime);
        });
      },
    ));
    return children;
  }
}

class _AlarmBox extends StatelessWidget {
  const _AlarmBox({Key? key, required this.time, required this.onPressedMinus})
      : super(key: key);

  final String time;
  final VoidCallback onPressedMinus;

  @override
  Widget build(BuildContext context) {
    final initTime = DateFormat('HH:mm').parse(time);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: onPressedMinus,
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
                    initalDateTime: initTime,
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
  const _TimePickerBottomSheet({Key? key, required this.initalDateTime})
      : super(key: key);

  final DateTime initalDateTime;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {},
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
                  onPressed: () {},
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
                  onPressed: () {},
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
  const _AddAlarmButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        textStyle: Theme.of(context).textTheme.subtitle1,
      ),
      onPressed: onPressed,
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
