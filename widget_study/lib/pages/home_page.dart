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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: (){},
            onLongPress: () {
              print("onLongPress");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            child: const Text("ElevatedButton")
          ),
          OutlinedButton(
            onPressed: (){},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.orange)
            ),
            child: const Text("OutlinedButton")
          ),
          TextButton(
            onPressed: (){},
            child: const Text("TextButton")
          ),
          GestureDetector(
            onTap: (){},
            onTapDown: (detail){
              print('onTapDown ${detail.kind} | ${detail.globalPosition}');
            },
            child: Container(
              color: Colors.yellow,
              height: 100,
            )
          ),
        ],
      ),
    );
  }
}
