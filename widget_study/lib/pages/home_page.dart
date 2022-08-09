import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Flutter AppBar")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
              setState(() {
                count++;
              });
            },
            child: const Text("plus")
          ),
          Center(
            child: Text('$count'),
          )
        ],
      ),
    );
  }
}
