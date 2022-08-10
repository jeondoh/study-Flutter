import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('page2'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            print('close btn click');
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'page2 hello',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      )
    );
  }
}
