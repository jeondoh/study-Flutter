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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.yellow,
            width: 100,
            height: 20,
            child: const Text('My Home Page1', style: TextStyle(fontSize: 24),),
          ),
          Container(
            color: Colors.green,
            width: 100,
            height: 50,
            child: const Text('My Home Page2', style: TextStyle(fontSize: 24),),
          ),
          Container(
            color: Colors.deepOrangeAccent,
            width: 100,
            height: 100,
            child: const Text('My Home Page3', style: TextStyle(fontSize: 24),),
          ),
        ],
      ),
    );
  }
}
