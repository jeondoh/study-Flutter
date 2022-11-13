import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  // 최대 높이
  double get maxExtent => maxHeight;

  @override
  // 최소 높이
  double get minExtent => minHeight;

  @override
  // covariant : 상속된 클래스도 사용가능
  // oldDelegate : build가 실행이 되었을 때 이전 delegate
  // shouldRebuild : 새로 빌드를 해야할지 말지 결정
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // APPBAR
          renderSliverAppBar(),
          // Persistent
          renderHeader(),
          // LIST
          renderBuilder(),
          // Persistent
          renderHeader(),
          renderSliverGridBuilder(),
        ],
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

  // -------------------- SliverAppBar -------------------- //
  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      // floating : 스크롤 했을때 리스트의 중간에도 Appbar가 내려오게 할 수 있음
      floating: true,
      // pinned : Appbar 고정여부
      pinned: false,
      // snap : floating이 true일때 사용
      // appbar가 스크롤시 자연스럽게 보이고 가려짐(자석효과)
      snap: true,
      // 맨 위에서 한계 이상으로 스크롤 했을때
      // 남는 공간을 차지
      stretch: true,
      // appbar height
      expandedHeight: 200,
      // appbar가 닫히는 구간 설정
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text("FlexibleSpace"),
        background: Image.asset(
          'asset/img/images.jpg',
          fit: BoxFit.cover,
        ),
      ),
      title: const Text('CustomScrollViewScreen'),
    );
  }

  // -------------------- SliverPersistentHeader ---------------- //
  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      // 최상단에(앱바아래) 고정가능
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              '신기하지?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        maxHeight: 150,
        minHeight: 75,
      ),
    );
  }

  // -------------------- SliverGrid -------------------- //
  // ListView 기본 생성자와 비슷함
  SliverList renderChildSliverList() {
    return SliverList(
      // 한번에 전체 출력
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
    );
  }

  // ListView.builder 생성자와 비슷
  SliverList renderBuilder() {
    return SliverList(
      // 보이는것만 그림
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 10,
      ),
    );
  }

  // GridView.count 와 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // GridView.builder 와 유사
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 30,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }
}
