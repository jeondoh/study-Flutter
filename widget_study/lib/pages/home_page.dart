import 'package:flutter/material.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: const Text("Flutter AppBar")
      ),
      body: Container(
        color: Colors.yellow,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 50,
        ),
        child: const Text('My Home Page'),
      ),
    );
  }
}
