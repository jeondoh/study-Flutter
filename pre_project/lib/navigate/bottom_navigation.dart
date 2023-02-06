import 'package:flutter/material.dart';
import 'package:pre_project/navigate/tab_item.dart';

List<BottomNavigationBarItem> navbarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.brunch_dining),
    label: '아침',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.lunch_dining),
    label: '점심',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.dinner_dining),
    label: '저녁',
  ),
];

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.currentTab,
    required this.onSelectTab,
  });
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.brunch),
        _buildItem(TabItem.lunch),
        _buildItem(TabItem.dinner),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      selectedItemColor: Colors.amber,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return navbarItems[tabIdx[tabItem]!];
  }
}
