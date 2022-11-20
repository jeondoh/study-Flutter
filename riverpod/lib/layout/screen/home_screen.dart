import 'package:flutter/material.dart';
import 'package:riverpod/layout/default_layout.dart';
import 'package:riverpod/layout/screen/state_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StateProviderScreen(),
                ),
              );
            },
            child: const Text('StateProciderScreen'),
          ),
        ],
      ),
    );
  }
}
