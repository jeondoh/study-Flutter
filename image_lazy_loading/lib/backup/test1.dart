import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Fucking Lazy Loading Test',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: const LazyLoading(),
      ),
    );
  }
}

class LazyLoading extends StatelessWidget {
  const LazyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      cacheExtent: 100,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 400,
        mainAxisSpacing: 17,
        crossAxisSpacing: 16,
      ),
      itemCount: 1000,
      itemBuilder: (context, index) {
        print(index);
        return Column(
          children: [
            Text(index.toString()),
            Image.network(
              'https://picsum.photos/${2400 + index}/${2400 + index}',
              key: ValueKey(index),
            ),
          ],
        );
      },
    );
  }
}
