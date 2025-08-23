import 'package:flutter/material.dart';
import 'package:navigation_theory/layout/default_layout.dart';
import 'package:navigation_theory/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    return DefaultLayout(
      title: 'RouteTwoScreen',
      children: [
        Text(
          arguments.toString(),
          textAlign: TextAlign.center,
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        OutlinedButton(
          onPressed: () {
            /*
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteThreeScreen();
                },
              ),
            );
            */
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 77777,
            );
          },
          child: Text('Push Route Three'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteThreeScreen();
                },
                settings: RouteSettings(
                  arguments: 1234,
                ),
              ),
            );
          },
          child: Text('Push Replacement'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              '/three',
              arguments: 9999,
            );
          },
          child: Text('Push Replacement Named'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) {
                // 삭제시 -> false
                // 미삭제시 -> true
                /// HomeRoute를 제외한 모든 라우트는 스택에서 제거됨
                return route.settings.name == '/';
              },
              arguments: 999,
            );
          },
          child: Text('Push Named And Remove Until'),
        )
      ],
    );
  }
}
