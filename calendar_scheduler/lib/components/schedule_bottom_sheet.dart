import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
  int? selectedColorId;

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
                    FutureBuilder<List<CategoryColor>>(
                        future: GetIt.I<LocalDatabase>().getCategoryColors(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              selectedColorId == null &&
                              snapshot.data!.isNotEmpty) {
                            selectedColorId = snapshot.data![0].id;
                          }

                          return _ColorPicker(
                            colors: snapshot.hasData ? snapshot.data! : [],
                            selectedColorId: selectedColorId!,
                            colorIdSetter: (int id) {
                              setState(() {
                                selectedColorId = id;
                              });
                            },
                          );
                        }),
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

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int selectedColorId;
  final ColorIdSetter colorIdSetter;

  const _ColorPicker({
    Key? key,
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(e, selectedColorId == e.id),
            ),
          )
          .toList(),
    );
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(
          int.parse('FF${color.hexCode}', radix: 16),
        ),
        border: isSelected
            ? Border.all(
                color: Colors.black,
                width: 4.0,
              )
            : null,
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
