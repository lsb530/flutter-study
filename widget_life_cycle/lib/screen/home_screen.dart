import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) {
    print('--- HomeScreen 생성자 ---');
  }

  @override
  Widget build(BuildContext context) {
    print('--- HomeScreen 빌드 ---');

    return Scaffold(
      body: BokiFactoryWidget(),
    );
  }
}

class BokiFactoryWidget extends StatelessWidget {
  BokiFactoryWidget({super.key}) {
    print('--- BokiFactoryWidget 생성자 ---');
  }

  @override
  Widget build(BuildContext context) {
    print('--- BokiFactoryWidget 빌드 ---');

    return Container(
      width: 50.0,
      height: 50.0,
      color: Colors.red,
    );
  }
}
