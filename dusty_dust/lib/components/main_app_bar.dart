import 'package:dusty_dust/model/status_model.dart';
import 'package:flutter/material.dart';

import '../model/stat_model.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status;
  final StatModel stat;

  const MainAppBar({
    Key? key,
    required this.status,
    required this.stat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      backgroundColor: status.primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            // kToolbarHeight : appbar 공간의 높이
            margin: const EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  '서울',
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(fontSize: 20.0),
                ),
                const SizedBox(height: 20.0),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(height: 20.0),
                Text(
                  status.label,
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  status.comment,
                  style: ts.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getTimeFromDateTime({required DateTime dateTime}) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${getTimeFormat(dateTime.hour)}:${getTimeFormat(dateTime.minute)}';
  }

  String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }
}
