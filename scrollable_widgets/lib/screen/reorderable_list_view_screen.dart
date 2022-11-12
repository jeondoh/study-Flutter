import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({Key? key}) : super(key: key);

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      // 화면에서 리스트의 순서를 바꿔줌
      // 마우스로 유저가 직접 순서를 바꿔줄 수 있음
      // 바꾸는 동시에 리랜더링이 일어남
      body: renderBuilder(),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      key: Key(index.toString()),
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

  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
      onReorder: (oldIndex, newIndex) {
        print('${oldIndex} : ${newIndex}');
        setState(() {
          // oldIndex 와 newIndex 모두 이동이 되기 전에 산정
          //
          // [red, orange, yellow]
          // [0, 1, 2]
          // red 를 yellow 다음으로 옮기고 싶다.
          // red : 0 oldIndex -> 3 newIndex (red 를 삭제하기(옮기기) 전 index)
          // [orange, yellow, red]
          //
          // [red, orange, yellow]
          // yellow 를 맨 앞으로 옮기고 싶다.
          // yellow : 2 oldIndex => 0 newIndex
          // [yellow, red, orange]
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }

  Widget renderBuilder() {
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[numbers[index] % rainbowColors.length],
          index: numbers[index],
        );
      },
      itemCount: numbers.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }
}
