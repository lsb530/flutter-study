import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod1/layout/default_layout.dart';
import 'package:riverpod1/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
      title: 'FutureProviderScreen',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          state.when(
            data: (data) {
              return Text(
                data.toString(),
                textAlign: TextAlign.center,
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
            loading: () {
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
