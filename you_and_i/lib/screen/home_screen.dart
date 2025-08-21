import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // 500이 기본값
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          // width: double.infinity,
          width: MediaQuery.of(context).size.width, // /2 /3 등을 할 수 있다.
          child: Column(
            children: [
              _Top(),
              /// 이미지
              _Bottom(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text(
              'U&I',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'parisienne',
                fontSize: 80.0,
              ),
            ),
            Text(
              '우리 처음 만난날',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'sunflower',
                fontSize: 30.0,
              ),
            ),
            Text(
              '2022.12.25',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'sunflower',
                fontSize: 20.0,
              ),
            ),
            IconButton(
              iconSize: 60.0,
              color: Colors.redAccent,
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
            Text(
              'D+1',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'sunflower',
                fontWeight: FontWeight.w700,
                fontSize: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Image.asset(
          'asset/img/middle_image.png',
        ),
      ),
    );
  }
}
