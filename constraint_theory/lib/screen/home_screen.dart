import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container( // Center가 없으면 좌상단에 위치
          height: 200,
          width: 200,
          color: Colors.red,
          child: Container( // 전체 영역 차지
            height: 50,
            width: 50,
            color: Colors.blue,
          )
          // child: Row(
          //   children: [
          //     Container(
          //       height: 50,
          //       width: 50,
          //       color: Colors.blue,
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
