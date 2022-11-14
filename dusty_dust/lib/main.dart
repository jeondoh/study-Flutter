import 'package:dusty_dust/model/stat_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screen/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  // stat_model.g.dart
  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'sunflower'),
      home: const HomeScreen(),
    ),
  );
}
