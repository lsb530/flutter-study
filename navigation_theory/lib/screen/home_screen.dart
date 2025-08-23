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
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteOneScreen(
                    number: 20,
                  );
                },
              ),
            );

            print(result);
          },
          child: Text('Push Route One'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(
              456,
            );
          },
          child: Text('Pop'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).maybePop(
              456,
            );
          },
          child: Text('Maybe Pop'),
        ),
      ],
    );
  }
}
