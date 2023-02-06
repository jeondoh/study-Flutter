import 'package:flutter/material.dart';
import 'package:pre_project/screen/main_dish.dart';

class DinnerScreen extends StatelessWidget {
  const DinnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text('dinner screen')),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainDish(menu: '저녁 학식'),
              ),
            );
          },
          child: const Text('보러가기'),
        ),
      ],
    );
  }
}
