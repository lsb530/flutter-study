import 'package:flutter/material.dart';
import 'package:navigation_theory/layout/default_layout.dart';
import 'package:navigation_theory/screen/route_two_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RouteOneScreen extends StatelessWidget {
  final int number;

  const RouteOneScreen({
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      // canPop: false,
      child: DefaultLayout(
        title: 'RouteOneScreen',
        children: [
          Text(
            'argument: $number',
            textAlign: TextAlign.center,
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
          OutlinedButton(
            onPressed: () {
              final canPop = Navigator.of(context).canPop();
              print('Pop 가능 ?: $canPop');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pop 가능 ?: $canPop')),
              );
              // Fluttertoast.showToast(
              //   msg: 'Pop 가능 ?: $canPop',
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.CENTER,
              // );
            },
            child: Text('Can Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RouteTwoScreen();
                  },
                  settings: RouteSettings(
                    arguments: 789,
                  ),
                ),
              );
            },
            child: Text('Push Route Two'),
          ),
        ],
      ),
    );
  }
}
