import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class NestedScreen extends StatelessWidget {
  final Widget child;

  const NestedScreen({
    super.key,
    required this.child,
  });

  int getIndex(BuildContext context) {
    final currentLocation = GoRouterState.of(context).location;
    if (currentLocation == '/nested/a') {
      return 0;
    } else if (currentLocation == '/nested/b') {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GoRouterState.of(context).location),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlueAccent,
        currentIndex: getIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/nested/a');
              return;
            case 1:
              context.go('/nested/b');
              return;
            default:
              context.go('/nested/c');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'person',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'notifications',
          ),
        ],
      ),
    );
  }
}
