import 'package:flutter/material.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Home Page")),
      body: const Center(child: Text('center'),),
    );
  }
}
