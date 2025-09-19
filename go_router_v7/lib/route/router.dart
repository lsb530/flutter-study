import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screen/1_basic_screen.dart';
import 'package:go_router_v7/screen/2_named_screen.dart';
import 'package:go_router_v7/screen/3_push_screen.dart';
import 'package:go_router_v7/screen/4_pop_base_screen.dart';
import 'package:go_router_v7/screen/5_pop_return_screen.dart';
import 'package:go_router_v7/screen/6_path_param_screen.dart';
import 'package:go_router_v7/screen/7_query_parameter_screen.dart';
import 'package:go_router_v7/screen/8_nested_child_screen.dart';
import 'package:go_router_v7/screen/8_nested_screen.dart';
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
        GoRoute(
          path: 'named',
          name: 'named_screen',
          builder: (context, state) => NamedScreen(),
        ),
        GoRoute(
          path: 'push',
          builder: (context, state) => PushScreen(),
        ),
        GoRoute(
          path: 'pop',
          builder: (context, state) => PopBaseScreen(),
          routes: [
            GoRoute(
              path: 'return',
              builder: (context, state) => PopReturnScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'path_param/:id',
          builder: (context, state) => PathParamScreen(),
          routes: [
            GoRoute(
              path: ':name',
              builder: (context, state) => PathParamScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) => QueryParameterScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return NestedScreen(
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: 'nested/a',
              builder: (context, state) => NestedChildScreen(
                routeName: '/nested/a',
              ),
            ),
            GoRoute(
              path: 'nested/b',
              builder: (context, state) => NestedChildScreen(
                routeName: '/nested/b',
              ),
            ),
            GoRoute(
              path: 'nested/c',
              builder: (context, state) => NestedChildScreen(
                routeName: '/nested/c',
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
