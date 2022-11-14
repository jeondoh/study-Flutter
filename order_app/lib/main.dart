import 'package:flutter/material.dart';

import 'user/view/login_screen.dart';

void main() {
  runApp(const _App());
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
      home: const LoginScreen(),
    );
  }
}
