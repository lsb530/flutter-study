import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (show) BokiFactoryWidget(), // Only can for []
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // 외부에도 가능은 하지만 명시적으로 내부에 코드 추천
                setState(() {
                  show = !show;
                });
              },
              child: Text('클릭해서 보이기/안보이기'),
            ),
          ],
        ),
      ),
    );
  }
}

class BokiFactoryWidget extends StatelessWidget {
  const BokiFactoryWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 50.0,
      height: 50.0,
      color: Colors.red,
    );
  }
}
