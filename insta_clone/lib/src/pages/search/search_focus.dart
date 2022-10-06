import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/src/components/image_data.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  Widget _tabMenu(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  PreferredSize buildPreferredSize() {
    return PreferredSize(
      // AppBar().preferredSize.height : AppBar 의 사이즈 만큼
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      // AppBar().preferredSize.height : AppBar 의 사이즈 만큼
      child: Container(
        height: AppBar().preferredSize.height,
        width: Size.infinite.width,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffe4e4e4))),
        ),
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black, // 포커스 시 밑줄색
          tabs: [
            _tabMenu('인기'),
            _tabMenu('계정'),
            _tabMenu('오디오'),
            _tabMenu('태그'),
            _tabMenu('장소'),
          ],
        ),
      ),
    );
  }

  Widget _tabBarBody() {
    return TabBarView(
      controller: _tabController,
      children: const [
        Center(child: Text('인기페이지')),
        Center(child: Text('계정페이지')),
        Center(child: Text('오디오페이지')),
        Center(child: Text('태그페이지')),
        Center(child: Text('장소페이지')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.backBtnIcon),
          ),
        ),
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: const Color(0xffefefef),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true,
            ),
          ),
        ),
        bottom: buildPreferredSize(),
      ),
      body: _tabBarBody(),
    );
  }
}
