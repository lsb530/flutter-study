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
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: colors.map((e) =>
              Container(
                height: 50.0,
                width: 50.0,
                color: e,
              ),
            ).toList(),
          ),
        ),
      ),
    );
    // return const Placeholder();
  }
}
