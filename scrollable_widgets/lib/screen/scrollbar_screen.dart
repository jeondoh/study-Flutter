import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ScrollBarScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ScrollBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "ScrollBarScreen",
      // 스크롤바 보이게 - Scrollbar 추가
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: numbers
                .map(
                  (e) => renderContainer(
                      color: rainbowColors[e % rainbowColors.length], index: e),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
