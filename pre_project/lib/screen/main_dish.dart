import 'package:flutter/material.dart';

class MainDish extends StatelessWidget {
  final String menu;
  const MainDish({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          menu,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
