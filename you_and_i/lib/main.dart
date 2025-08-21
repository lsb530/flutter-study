import 'package:flutter/material.dart';
import 'package:you_and_i/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'parisienne',
            fontSize: 80.0,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 50.0,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      home: HomeScreen(),
    ),
  );
}