import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? content;
  int? startTime;
  int? endTime;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(onStartSaved: (String? val) {
                      startTime = int.parse(val!);
                    }, onEndSaved: (String? val) {
                      endTime = int.parse(val!);
                    }),
                    const SizedBox(height: 16.0),
                    _Content(onSaved: (String? val) {
                      content = val;
                    }),
                    const SizedBox(height: 16.0),
                    const _ColorPicker(),
                    const SizedBox(height: 8.0),
                    _SaveBtn(onPressed: onSavePressed),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({
    Key? key,
    required this.onStartSaved,
    required this.onEndSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작 시간',
          isTime: true,
          onSaved: onStartSaved,
        )),
        const SizedBox(width: 16.0),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
          isTime: true,
          onSaved: onEndSaved,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Content({Key? key, required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
      child: Row(
        children: const [
          Expanded(
            child: Center(child: Text('저장')),
          ),
        ],
      ),
    );
  }
}
