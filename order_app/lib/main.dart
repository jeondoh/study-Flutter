import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/common/view/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      // 우측 위 디버그 라벨 제거
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
