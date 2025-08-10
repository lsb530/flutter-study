import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // DRY - Do Not Repeat Yourself
            Container(
              height: 50.0,
              width: 50.0,
              color: Colors.red,
            ),
            Container(
              height: 50.0,
              width: 50.0,
              color: Colors.orange,
            ),
            Container(
              height: 50.0,
              width: 50.0,
              color: Colors.yellow,
            ),
            Container(
              height: 50.0,
              width: 50.0,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
    // return const Placeholder();
  }
}
