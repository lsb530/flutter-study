import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screen/1_basic_screen.dart';
import 'package:go_router_v7/screen/root_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => RootScreen(),
      routes: [
        GoRoute(
          path: 'basic',
          builder: (context, state) => BasicScreen(),
        ),
      ],
    ),
  ],
);
