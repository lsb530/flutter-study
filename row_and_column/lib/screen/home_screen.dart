import 'package:flutter/material.dart';
import '../const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          // width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  color: Colors.red,
                ),
              ),
              Expanded(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  color: Colors.orange,
                ),
              ),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
    // return const Placeholder();
  }
}
