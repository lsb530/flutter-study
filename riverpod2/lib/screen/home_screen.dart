import 'package:flutter/material.dart';
import 'package:riverpod2/layout/default_layout.dart';
import 'package:riverpod2/screen/code_generation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => CodeGenerationScreen()));
            },
            child: Text('CodeGenerationScreen'),
          ),
        ],
      ),
    );
  }
}
