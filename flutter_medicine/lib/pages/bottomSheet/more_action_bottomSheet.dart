import 'package:flutter/material.dart';
import 'package:flutter_medicine/components/common_widgets.dart';

class MoreActionButtonSheet extends StatelessWidget {
  const MoreActionButtonSheet(
      {Key? key,
      required this.onPressedModify,
      required this.onPressedDeleteOnlyMedicine,
      required this.onPressedDeleteAll})
      : super(key: key);

  final VoidCallback? onPressedModify;
  final VoidCallback? onPressedDeleteOnlyMedicine;
  final VoidCallback? onPressedDeleteAll;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(
          onPressed: onPressedModify,
          child: const Text('약 정보 수정'),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.red),
          onPressed: onPressedDeleteOnlyMedicine,
          child: const Text('약 정보 삭제'),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.red),
          onPressed: onPressedDeleteAll,
          child: const Text('약 기록과 함께 정보 삭제'),
        ),
      ],
    );
  }
}
