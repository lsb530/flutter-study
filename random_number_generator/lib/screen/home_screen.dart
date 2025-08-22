import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 제목 & 아이콘
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('제목'),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                  ),
                ),
              ],
            ),

            // 숫자
            Expanded(
              child: Text('''
              123
              456
              789
              '''),
            ),

            // 버튼
            ElevatedButton(
              onPressed: () {},
              child: Text('생성하기!'),
            ),
          ],
        ),
      ),
    );
  }
}
