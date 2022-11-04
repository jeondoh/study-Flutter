import 'package:flutter/material.dart';
import 'package:insta_clone/src/components/avatar_widget.dart';
import 'package:insta_clone/src/components/image_data.dart';

import 'user_card.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'jeondoh',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ImageData(IconsPath.uploadIcon, width: 50),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.menuIcon, width: 50),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _information(),
            _menu(),
            _discorverPeople(),
            const SizedBox(height: 20),
            _tabMenu(),
            _tabView(),
          ],
        ),
      ),
    );
  }

  Widget _discorverPeople() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Discover People',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: List.generate(
                10,
                (index) => UserCard(
                      userId: '개남$index',
                      description: '개남e$index님이 팔로우합니다.',
                    )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _staticsOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const AvatarWidget(
                type: AvatarType.TYPE3,
                thumbPath:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-fff2lftqIE077pFAKU1Mhbcj8YFvBbMvpA&usqp=CAU',
                size: 80,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _staticsOne('Post', 8)),
                    Expanded(child: _staticsOne('Followers', 1325)),
                    Expanded(child: _staticsOne('Following', 13)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '안녕하세요. 개발자입니다.',
            style: TextStyle(fontSize: 13, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: const Color(0xffdedede)),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: const Color(0xffdedede)),
              color: const Color(0xffefefef),
            ),
            child: ImageData(IconsPath.addFriend),
          ),
        ],
      ),
    );
  }

  Widget _tabMenu() {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      tabs: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ImageData(IconsPath.gridViewOn),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ImageData(IconsPath.gridViewOff),
        ),
      ],
    );
  }

  Widget _tabView() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey,
          );
        });
  }
}
