import 'package:flutter/material.dart';
import 'package:navigation_theory/layout/default_layout.dart';
import 'package:navigation_theory/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteOneScreen();
                },
              ),
            );
          },
          child: Text('Push'),
        ),
      ],
    );
  }
}
