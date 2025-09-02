import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrollable_widgets_theory/const/colors.dart';

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
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override // 최대 높이
  double get maxExtent => maxHeight;

  @override // 최소 높이
  double get minExtent => minHeight;

  @override
  // covariant -> 상속된 클래스도 사용가능
  // oldDelegate -> build가 실행이 됐을 때 이전 Delegate
  // this -> 새로운 delegate
  // shouldRebuild -> 새로 build를 해야할지 말지 결정
  // ㄴfalse: 빌드 X, true: 빌드 O
  // bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderSliverGridBuilder(),
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderSliverGridBuilder(),
          renderHeader(),
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
      key: Key(index.toString()),
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  Widget needToCustomView() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: rainbowColors
                .map(
                  (e) => renderContainer(
                    color: e,
                    index: 1,
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: rainbowColors
                .map(
                  (e) => renderContainer(
                    color: e,
                    index: 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  /// 1) ListView 기본 생성자와 유사
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  /// 2) ListView.builder 생성자와 유사
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 10, // Optional
      ),
    );
  }

  /// 3) GridView.count 유사
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  /// 4) GridView.builder 유사
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 31, // Optional
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  /// 5) SliverAppBar(pinned, floating, snap, stretch, expandedHeight, collapsedHeight, flexibleSpace)
  SliverAppBar renderSliverAppbar() {
    final int random = Random().nextInt(5) + 1;

    return SliverAppBar(
      title: Text('CustomScrollViewScreen'),
      // 고정된 상태로 나옴(기본값: false)
      pinned: false,
      // 아래로 스크롤할때는 사라지다가 위로 스크롤 할때는 생김(기본값: false)
      floating: true,
      // 자석효과. false일때는 애니메이션이 사라져서 중간 크기 렌더링 가능(floating true여야만 효과를 볼 수 있음)
      snap: false,
      // 맨 위에서 한계 이상으로 스크롤 할 경우 남는 공간을 차지(기본값: false)
      stretch: true,
      // 기본 높이(확장된)
      expandedHeight: 200,
      // 닫힐 때의 높이(작으면 더 빨리 닫힘)
      collapsedHeight: 150,
      // 닫힐 때 공간을 차지할 것(위젯도 넣을 수 있음)
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/img/image_$random.jpeg',
          fit: BoxFit.cover,
        ),
        title: Text('FlexibleSpace'),
      ),
      backgroundColor: Colors.blue[200],
    );
  }

  /// 6) SliverPersistentHeader
  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              '신기하지~',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        minHeight: 100,
        maxHeight: 150,
      ),
    );
  }
}
