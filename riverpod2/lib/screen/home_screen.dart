import 'package:flutter/material.dart';
import 'package:riverpod2/layout/default_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      body: ListView(
        children: [],
      ),
    );
  }
}
