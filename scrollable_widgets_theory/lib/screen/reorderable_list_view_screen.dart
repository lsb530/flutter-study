import 'package:flutter/material.dart';
import 'package:scrollable_widgets_theory/const/colors.dart';
import 'package:scrollable_widgets_theory/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

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
      body: renderBuilder2(),
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

  /// 1) 기본 - onReorder를 꼭 구현해줘야 함. 최적화 X
  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) =>
            renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
      )
          .toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          /// oldIndex, newIndex 모두 이동이 되기 전에 선정
          // 1. [red, orange, yellow] == [0, 1, 2]
          // - Goal: red를 yellow 다음으로 옮기고 싶다.
          // red: 0(oldIndex) -> 3(newIndex)
          // [orange, yellow, red]

          // 2. [red, orange, yellow]
          // - Goal: yellow를 맨 앞으로 옮기고 싶다.
          // yello: 2(oldIndex) -> 0(newIndex)
          // [yellow, red, orange]
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final removedItem = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, removedItem);
        });
      },
    );
  }

  /// 2) 빌더 - 순서와 색상이 자동으로 생성되는 index를 바라보기 때문에 변경된다. 최적화 O
  Widget renderBuilder1() {
    return ReorderableListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final removedItem = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, removedItem);
        });
      },
    );
  }

  /// 3) 빌더 - 순서와 색상이 위에서 만들어준 배열 주소값의 index를 바라보기 때문에 변경되지 않는다. 최적화 O
  Widget renderBuilder2() {
    return ReorderableListView.builder(
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[numbers[index] % rainbowColors.length],
          index: numbers[index],
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final removedItem = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, removedItem);
        });
      },
    );
  }

}
