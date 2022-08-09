import 'package:flutter/material.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Flutter AppBar")
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
        color: Colors.yellowAccent,
      ),
    );
  }
}
