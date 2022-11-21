import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_study/provider/provider_observer.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        Logger(),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
