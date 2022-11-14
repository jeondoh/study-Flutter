import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:flutter/material.dart';

import '../components/hourly_card.dart';
import '../components/main_app_bar.dart';
import '../components/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<StatModel>> fetchData() async {
    final statModels = await StatRepository.fetchData();
    return statModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // drawer : 왼쪽 메뉴 생성
      drawer: const MainDrawer(),
      body: FutureBuilder<List<StatModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error!!'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<StatModel> stats = snapshot.data!;
            StatModel recentStat = stats[0];
            final status = statusLevel
                .where((element) => element.minFineDust < recentStat.seoul)
                .last;

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  stat: recentStat,
                  status: status,
                ),
                // sliver 안에 일반 위젯을 넣을 수 있음
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      CategoryCard(),
                      SizedBox(height: 16.0),
                      HourlyCard(),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
