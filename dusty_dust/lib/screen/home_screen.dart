import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

import '../components/main_app_bar.dart';
import '../components/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // drawer : 왼쪽 메뉴 생성
      drawer: const MainDrawer(),
      body: CustomScrollView(
        slivers: [
          const MainAppBar(),
          // sliver 안에 일반 위젯을 넣을 수 있음
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
