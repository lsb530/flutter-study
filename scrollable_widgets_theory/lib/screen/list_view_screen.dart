import 'package:flutter/material.dart';
import 'package:scrollable_widgets_theory/const/colors.dart';
import 'package:scrollable_widgets_theory/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparated(),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      // height: (height == null) ? 300 : height,
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

  /// 1) 기본 - 모두 한번에 렌더링(화면에 보이지 않아도, SingleChildScrollView와 같은 렌더링 방식)
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map(
            (e) =>
            renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
      )
          .toList(),
    );
  }

  /// 2) 보이는 것만 렌더링
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  /// 3) 2번 + 중간 중간에 위젯 추가 가능
  Widget renderSeparated() {
    return ListView.separated(
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        index += 1;

        // 5개의 item마다 배너 보여주기
        if (index % 5 == 0) {
          return renderContainer(
            color: Colors.black,
            index: index,
            height: 100,
          );
        }

        // return Container();
        return SizedBox(height: 32.0);
      },
    );
  }
}
