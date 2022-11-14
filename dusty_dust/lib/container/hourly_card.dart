import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/card_title.dart';
import '../components/main_card.dart';
import '../model/stat_model.dart';

class HourlyCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final String region;
  final ItemCode itemCode;

  const HourlyCard({
    Key? key,
    required this.darkColor,
    required this.lightColor,
    required this.region,
    required this.itemCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간별 ${DataUtils.getItemCodeKrString(itemCode: itemCode)}',
            backgroundColor: darkColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: ValueListenableBuilder<Box>(
              valueListenable: Hive.box<StatModel>(itemCode.name).listenable(),
              builder: (context, box, widget) => Column(
                children:
                    box.values.map((stat) => renderRow(stat: stat)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderRow({required StatModel stat}) {
    final status = DataUtils.getStatusFromItemCodeAndValue(
      value: stat.getLevelFromRegion(region),
      itemCode: stat.itemCode,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${stat.dataTime.hour.toString().padLeft(2, '0')}시',
          ),
          Image.asset(
            status.imagePath,
            height: 20.0,
          ),
          Text(status.label),
        ],
      ),
    );
  }
}
