import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: redColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('저장!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
