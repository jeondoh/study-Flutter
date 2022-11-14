import 'package:flutter/material.dart';

import '../const/regions.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;
  final Color lightColor;
  final Color darkColor;

  const MainDrawer({
    Key? key,
    required this.onRegionTap,
    required this.selectedRegion,
    required this.lightColor,
    required this.darkColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              '지역 선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          ...regions
              .map(
                (e) => ListTile(
                  tileColor: Colors.white,
                  selectedTileColor: lightColor,
                  selectedColor: Colors.black,
                  selected: e == selectedRegion,
                  onTap: () {
                    onRegionTap(e);
                  },
                  title: Text(e),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
