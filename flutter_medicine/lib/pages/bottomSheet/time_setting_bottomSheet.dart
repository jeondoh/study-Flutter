import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/common_widgets.dart';
import 'package:flutter_medicine/components/medicine_colors.dart';
import 'package:flutter_medicine/components/medicine_constants.dart';
import 'package:intl/intl.dart';

class TimeSettingBottomSheet extends StatelessWidget {
  const TimeSettingBottomSheet({
    Key? key,
    required this.initialTime,
  }) : super(key: key);

  final String initialTime;

  @override
  Widget build(BuildContext context) {
    final initialDateTime = DateFormat('HH:mm').parse(initialTime);
    DateTime setDateTime = initialDateTime;

    return BottomSheetBody(
      children: [
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {
              setDateTime = dateTime;
            },
            mode: CupertinoDatePickerMode.time,
            initialDateTime: initialDateTime,
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
                  onPressed: () => Navigator.pop(context, setDateTime),
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
