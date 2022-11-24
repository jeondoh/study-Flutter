import 'package:flutter/material.dart';
import 'package:order_app/common/layout/default_layout.dart';
import 'package:order_app/product/view/product_screen.dart';

import '../../restaurant/view/restaurant_screen.dart';
import '../../user/view/profile_screen.dart';
import '../const/colors.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'root';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        // shifting : 선택된 아이템이 크게 보임
        // fixed : 일반적인 탭
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
      ),
      child: TabBarView(
        // tabBar 에서 스크롤 불가 설정
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          const RestaurantScreen(),
          const ProductScreen(),
          Center(child: Container(child: Text('주문'))),
          const ProfileScreen(),
        ],
      ),
    );
  }
}
