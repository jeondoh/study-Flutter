import 'package:flutter/material.dart';
import 'package:widget_study/pages/page2.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('page1'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'hello',
                style: Theme.of(context).textTheme.headline4
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Page2(),));
                },
                child: const Text('page2로 이동'))
            ],
          ),
        ),
      ),
    );
  }
}
