import 'package:dio/dio.dart';
import 'package:dusty_dust/container/category_card.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/main_app_bar.dart';
import '../components/main_drawer.dart';
import '../const/regions.dart';
import '../container/hourly_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    fetchData();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final now = DateTime.now();
      final fetchTime = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
      );

      final box = Hive.box<StatModel>(ItemCode.PM10.name);

      // 데이터 중복으로 가져오기 방지
      if (box.values.isNotEmpty &&
          (box.values.last).dataTime.isAtSameMomentAs(fetchTime)) {
        print('이미 최신 데이터가 있습니다.');
        return;
      }

      List<Future> futures = [];

      // 동시요청
      for (ItemCode itemCode in ItemCode.values) {
        futures.add(StatRepository.fetchData(itemCode: itemCode));
      }
      // 동시요청 후에 끝날때 까지 기다림
      final results = await Future.wait(futures);

      for (int i = 0; i < results.length; i++) {
        // ItemCode
        final key = ItemCode.values[i];
        // List<StatModel>
        final value = results[i];

        final box = Hive.box<StatModel>(key.name);

        for (StatModel stat in value) {
          box.put(stat.dataTime.toString(), stat);
        }

        final allKeys = box.keys.toList();
        if (allKeys.length > 24) {
          // start - 시작 인덱스
          // end - 끝 인덱스
          // ['red', 'orange', 'yellow', 'green', 'blue']
          // .sublist(1, 3)
          // ['orange', 'yellow']
          final deleteKeys = allKeys.sublist(0, allKeys.length - 24);
          box.deleteAll(deleteKeys);
        }
      }
    } on DioError catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('인터넷 연결이 원활하지 않습니다.'),
        ),
      );
    }
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;
    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        if (box.values.isEmpty) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final recentStat = box.values.toList().last;
        // 미세먼지 최근 데이터의 현재 상태
        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: recentStat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );

        return Scaffold(
          // drawer : 왼쪽 메뉴 생성
          drawer: MainDrawer(
            darkColor: status.darkColor,
            lightColor: status.lightColor,
            selectedRegion: region,
            onRegionTap: (String region) {
              setState(() {
                this.region = region;
              });
              Navigator.of(context).pop();
            },
          ),
          body: Container(
            color: status.primaryColor,
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchData();
              },
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  MainAppBar(
                    isExpanded: isExpanded,
                    region: region,
                    stat: recentStat,
                    status: status,
                    dateTime: recentStat.dataTime,
                  ),
                  // sliver 안에 일반 위젯을 넣을 수 있음
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                          region: region,
                        ),
                        const SizedBox(height: 16.0),
                        ...ItemCode.values.map(
                          (itemCode) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: HourlyCard(
                                region: region,
                                darkColor: status.darkColor,
                                lightColor: status.lightColor,
                                itemCode: itemCode,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
