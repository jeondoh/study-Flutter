import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

import '../components/hourly_card.dart';
import '../components/main_app_bar.dart';
import '../components/main_drawer.dart';
import '../const/regions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};
    List<Future> futures = [];

    // 동시요청
    for (ItemCode itemCode in ItemCode.values) {
      futures.add(StatRepository.fetchData(itemCode: itemCode));
    }
    // 동시요청 후에 끝날때 까지 기다림
    final results = await Future.wait(futures);

    for (int i = 0; i < results.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];
      stats.addAll({key: value});
    }
    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // drawer : 왼쪽 메뉴 생성
      drawer: MainDrawer(
        selectedRegion: region,
        onRegionTap: (String region) {
          setState(() {
            this.region = region;
          });
          Navigator.of(context).pop();
        },
      ),
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
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

            Map<ItemCode, List<StatModel>> stats = snapshot.data!;
            StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

            final status = DataUtils.getStatusFromItemCodeAndValue(
              value: pm10RecentStat.seoul,
              itemCode: ItemCode.PM10,
            );

            final ssModel = stats.keys.map((key) {
              final value = stats[key]!;
              final stat = value[0];

              return StatAndStatusModel(
                itemCode: key,
                status: DataUtils.getStatusFromItemCodeAndValue(
                  value: stat.getLevelFromRegion(region),
                  itemCode: key,
                ),
                stat: stat,
              );
            }).toList();

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  region: region,
                  stat: pm10RecentStat,
                  status: status,
                ),
                // sliver 안에 일반 위젯을 넣을 수 있음
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        models: ssModel,
                        region: region,
                      ),
                      const SizedBox(height: 16.0),
                      const HourlyCard(),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
