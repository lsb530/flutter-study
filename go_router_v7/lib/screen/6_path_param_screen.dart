import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class PathParamScreen extends StatelessWidget {
  const PathParamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Center(
        child: ListView(
          children: [
            Text('Path Param: ${GoRouterState.of(context).pathParameters}'),
            ElevatedButton(
              onPressed: () {
                context.go('/path_param/456/code-boki');
              },
              child: Text('Path Param'),
            ),
          ],
        ),
      ),
    );
  }
}
