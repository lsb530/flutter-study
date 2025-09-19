import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screen/10_transition_screen1.dart';
import 'package:go_router_v7/screen/10_transition_screen2.dart';
import 'package:go_router_v7/screen/1_basic_screen.dart';
import 'package:go_router_v7/screen/2_named_screen.dart';
import 'package:go_router_v7/screen/3_push_screen.dart';
import 'package:go_router_v7/screen/4_pop_base_screen.dart';
import 'package:go_router_v7/screen/5_pop_return_screen.dart';
import 'package:go_router_v7/screen/6_path_param_screen.dart';
import 'package:go_router_v7/screen/7_query_parameter_screen.dart';
import 'package:go_router_v7/screen/8_nested_child_screen.dart';
import 'package:go_router_v7/screen/8_nested_screen.dart';
import 'package:go_router_v7/screen/9_login_screen.dart';
import 'package:go_router_v7/screen/9_private_screen.dart';
import 'package:go_router_v7/screen/root_screen.dart';

// true: login O / false: login X
bool authState = false;

final router = GoRouter(
  redirect: (context, state) {
    // return
    //    string(path): 해당 라우트로 이동
    //    null: 원래 이동하려던 라우트로 이동
    if (state.location == '/login/private' && !authState) {
      return '/login';
    }

    return null;
  },
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
        GoRoute(
          path: 'login',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (context, state) => PrivateScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'login2',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (context, state) => PrivateScreen(),
              redirect: (context, state) => !authState ? '/login2' : null,
            ),
          ],
        ),
        GoRoute(
          path: 'transition',
          builder: (context, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
              path: 'detail',
              // builder: (context, state) => TransitionScreenTwo(),
              pageBuilder: (_, state) => CustomTransitionPage(
                transitionDuration: Duration(seconds: 3),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );

                      // return ScaleTransition(
                      //   scale: animation,
                      //   child: child,
                      // );

                      // return RotationTransition(
                      //   turns: animation,
                      //   child: child,
                      // );
                    },
                child: TransitionScreenTwo(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
