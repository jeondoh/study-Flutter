import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Text(
                'U&I',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'parisienne',
                    fontSize: 80.0),
              ),
              const Text(
                '우리 처음 만난날',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sunflower',
                  fontSize: 30.0,
                ),
              ),
              const Text(
                '2022.07.08',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sunflower',
                  fontSize: 20.0,
                ),
              ),
              IconButton(
                iconSize: 60.0,
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              const Text(
                "D+1",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sunflower',
                  fontWeight: FontWeight.w700,
                  fontSize: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
