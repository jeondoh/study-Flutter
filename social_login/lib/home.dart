import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mainPage.dart';
import 'profilePage.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  int _currentIndex = 0;
  final _pages = [
    const MainPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('예림이 그패봐봐')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      child: Container(
        height: kBottomNavigationBarHeight,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
              onPressed: (() => _onCurrentPage(0)),
              child: Icon(
                CupertinoIcons.home,
                color: _currentIndex == 0
                    ? const Color(0xFF151515)
                    : Colors.grey[350],
              ),
            ),
            CupertinoButton(
              onPressed: (() => _onCurrentPage(1)),
              child: Icon(
                CupertinoIcons.profile_circled,
                color: _currentIndex == 1
                    ? const Color(0xFF151515)
                    : Colors.grey[350],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCurrentPage(int pageIndex) {
    return setState(() {
      _currentIndex = pageIndex;
    });
  }
}
