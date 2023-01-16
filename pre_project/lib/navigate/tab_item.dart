import 'package:flutter/material.dart';
import 'package:pre_project/main/brunch_screen.dart';
import 'package:pre_project/main/dinner_screen.dart';
import 'package:pre_project/main/lunch_screen.dart';

enum TabItem {
  brunch,
  lunch,
  dinner,
}

const Map<TabItem, int> tabIdx = {
  TabItem.brunch: 0,
  TabItem.lunch: 1,
  TabItem.dinner: 2,
};

Map<TabItem, Widget> tabScreen = {
  TabItem.brunch: const BrunchScreen(),
  TabItem.lunch: const LunchScreen(),
  TabItem.dinner: const DinnerScreen(),
};
