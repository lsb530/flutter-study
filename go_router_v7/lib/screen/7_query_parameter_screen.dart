import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class QueryParameterScreen extends StatelessWidget {
  const QueryParameterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Center(
        child: ListView(
          children: [
            Text('Query Param: ${GoRouterState.of(context).queryParameters}'),
            ElevatedButton(
              onPressed: () {
                context.go( // or push()
                  Uri(
                    path: '/query_param',
                    queryParameters: {
                      'name': 'boki',
                      'age': '20',
                    }
                  ).toString(),
                );
              },
              child: Text('Query Parameter'),
            ),
          ],
        ),
      ),
    );
  }
}
