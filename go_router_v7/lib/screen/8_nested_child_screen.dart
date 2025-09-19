import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class NestedChildScreen extends StatelessWidget {
  final String routeName;

  const NestedChildScreen({
    super.key,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(routeName),
    );
  }
}
