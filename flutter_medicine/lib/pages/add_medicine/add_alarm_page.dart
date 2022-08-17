import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/medicine_constants.dart';
import 'package:flutter_medicine/pages/add_medicine/components/add_page_widget.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage(
      {Key? key, required this.medicineImage, required this.medicineName})
      : super(key: key);

  final File? medicineImage;
  final String medicineName;

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
              children: const [
                _AlarmBox(),
                _AlarmBox(),
                _AddAlarmButton(),
              ],
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
}

class _AlarmBox extends StatelessWidget {
  const _AlarmBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.minus_circle),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: () {},
            child: const Text("10:00"),
          ),
        )
      ],
    );
  }
}

class _AddAlarmButton extends StatelessWidget {
  const _AddAlarmButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        textStyle: Theme.of(context).textTheme.subtitle1,
      ),
      onPressed: () {},
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
