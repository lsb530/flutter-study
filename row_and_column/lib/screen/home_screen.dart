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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
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
