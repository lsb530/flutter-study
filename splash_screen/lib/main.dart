import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.blue,
        // Hex Code: 335CB0
        backgroundColor: Color(0xFF335CB0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/img/logo.png'),
          ],
        ),
      ),
    ),
  );
}
