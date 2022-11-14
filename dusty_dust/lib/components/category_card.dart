import 'package:dusty_dust/components/card_title.dart';
import 'package:dusty_dust/components/main_card.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

import '../model/stat_and_status_model.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final List<StatAndStatusModel> models;

  const CategoryCard({
    Key? key,
    required this.region,
    required this.models,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CardTitle(title: '종류별 통계'),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: PageScrollPhysics(),
                    children: models
                        .map(
                          (model) => MainStat(
                            width: constraint.maxWidth / 3,
                            category: DataUtils.getItemCodeKrString(
                              itemCode: model.itemCode,
                            ),
                            imgPath: model.status.imagePath,
                            level: model.status.label,
                            stat:
                                '${model.stat.getLevelFromRegion(region)}${DataUtils.getUnitFromItemCode(itemCode: model.itemCode)}',
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
