import 'package:dio/dio.dart';
import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/const/data.dart';
import 'package:flutter/material.dart';

import '../components/hourly_card.dart';
import '../components/main_app_bar.dart';
import '../components/main_drawer.dart';
import '../model/stat_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'numberOfRows': 30,
        'pageNo': 1,
        'itemCode': 'PM10',
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    print(
      response.data['response']['body']['items'].map(
        (item) => StatModel.fromJson(json: item),
      ),
    );
  }

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
              children: const [
                CategoryCard(),
                SizedBox(height: 16.0),
                HourlyCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
