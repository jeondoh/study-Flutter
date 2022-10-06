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
        bottom: PreferredSize(
          // AppBar().preferredSize.height : AppBar 의 사이즈 만큼
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          // AppBar().preferredSize.height : AppBar 의 사이즈 만큼
          child: Container(
            height: AppBar().preferredSize.height,
            width: Size.infinite.width,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Text(
                  '인기',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  '계정',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  '오디오',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  '태그',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  '장소',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
