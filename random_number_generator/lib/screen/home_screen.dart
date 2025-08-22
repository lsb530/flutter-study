import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numbers = [
    123,
    456,
    789
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 제목 & 아이콘
              _Header(onPressed: onSettingIconPressed),

              /// 숫자
              _Body(numbers: numbers),

              /// 버튼
              _Footer(onPressed: generateRandomNumbers),
            ],
          ),
        ),
      ),
    );
  }

  onSettingIconPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingScreen();
        }
      ),
    );
  }

  generateRandomNumbers() {
    final rand = Random();

    final Set<int> newNumbers = {};

    while(newNumbers.length < 3) {
      final randomNumber = rand.nextInt(1000);
      newNumbers.add(randomNumber);
    }

    setState(() {
      numbers = newNumbers.toList();
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤 숫자 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          color: redColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> numbers;

  const _Body({
    required this.numbers,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numbers
          .map((numbers) => numbers.toString().split('')).toList()
          .map((e) =>
            Row(children: e.map((number) =>
            Image.asset(
              'asset/img/$number.png',
              width: 50.0,
              height: 70.0,
            ))
            .toList()
          )
        ).toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text('생성하기!'),
    );
  }
}
