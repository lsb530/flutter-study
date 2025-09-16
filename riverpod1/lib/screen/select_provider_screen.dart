import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod1/layout/default_layout.dart';
import 'package:riverpod1/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');

    /// watch: build 재실행(+ select() isSpicy가 변경될 때만으로 한정)
    final state = ref.watch(
      selectProvider.select(
        (value) => value.isSpicy,
      ),
    );

    /// listen: build 재실행 X(+ select() hasBought 변경될 때만으로 한정)
    ref.listen(
      selectProvider.select(
        (value) => value.hasBought,
      ),
      (previous, next) {
        print('next: $next');
      },
    );

    return DefaultLayout(
      title: 'SelectProviderScreen',
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.toString()),
            // Text('name: ${state.name}'),
            // Text('isSpicy: ${state.isSpicy.toString()}'),
            // Text('hasBought: ${state.hasBought.toString()}'),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleIsSpicy();
              },
              child: Text('Spicy Toggle'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleHasBought();
              },
              child: Text('HasBought Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}
