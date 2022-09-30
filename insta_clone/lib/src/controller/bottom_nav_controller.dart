import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/message_popup.dart';
import '../pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => const Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.isEmpty) {
      bottomHistory.add(0);
    }
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.isEmpty) {
      _setMessagePop(bottomHistory);
      return true;
    } else {
      bottomHistory.removeLast();
      if (bottomHistory.isEmpty) {
        _setMessagePop(bottomHistory);
        return true;
      }
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }
}

void _setMessagePop(List<int> bottomHistory) {
  showDialog(
    context: Get.context!,
    builder: (context) => MessagePopup(
      title: '시스템',
      message: '종료하시겠습니까?',
      okCallback: () {
        exit(0);
      },
      cancelCallback: () {
        bottomHistory = [0];
        Get.back();
      },
    ),
  );
}
