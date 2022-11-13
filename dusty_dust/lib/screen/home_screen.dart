import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

import '../components/main_app_bar.dart';
import '../components/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      // drawer : 왼쪽 메뉴 생성
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
        ],
      ),
    );
  }
}
