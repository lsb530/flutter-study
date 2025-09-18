import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Center(
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                /// 이전 화면으로 이동
                context.push('/basic');
              },
              child: Text('Push Basic'),
            ),
            ElevatedButton(
              onPressed: () {
                /// routes에 선언된 상위 route로 이동
                context.go('/basic');
              },
              child: Text('Go Basic'),
            ),
          ],
        ),
      ),
    );
  }
}
