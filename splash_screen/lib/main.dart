import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          // child: Text("Hello Boki"),
          child: Image.asset('asset/img/logo.png')
        ),
      ),
    ),
  );
}
