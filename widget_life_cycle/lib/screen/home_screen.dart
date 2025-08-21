import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = false;
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (show) GestureDetector(
              onTap: () {
                setState(() {
                  color = color == Colors.blue ? Colors.red : Colors.blue;
                });
              },
              child: BokiFactoryWidget(
                color: color,
              ),
            ), // Only can for []
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

class BokiFactoryWidget extends StatefulWidget {
  final Color color;

  BokiFactoryWidget({
    super.key,
    required this.color,
  }) {
    print('1) Stateful Widget Constructor');
  }

  @override
  State<BokiFactoryWidget> createState() {
    print('2) Stateful Widget Create State');

    return _BokiFactoryWidgetState();
  }
}

class _BokiFactoryWidgetState extends State<BokiFactoryWidget> {
  @override
  void initState() {
    print('3) Stateful Widget initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('4) Stateful Widget didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('5) Stateful Widget build');
    return Container(
      color: widget.color,
      width: 50.0,
      height: 50.0,
    );
  }

  @override
  void deactivate() {
    print('6) Stateful Widget deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('7) Stateful Widget dispose');
    super.dispose();
  }
}
