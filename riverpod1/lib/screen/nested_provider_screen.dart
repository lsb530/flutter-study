import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod1/layout/default_layout.dart';
import 'package:riverpod1/riverpod/nested_provider.dart';
import 'package:riverpod1/riverpod/state_notifier_provider.dart';

class NestedProviderScreen extends ConsumerWidget {
  const NestedProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filteredShoppingListProvider);

    print(state);

    return DefaultLayout(
      title: 'NestedProviderScreen',
      actions: [
        PopupMenuButton<FilterSpicyState>(
          itemBuilder: (context) => FilterSpicyState.values
              .map(
                (e) => PopupMenuItem(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onSelected: (value) {
            ref.read(filterProvider.notifier).update((state) => value);
          },
        ),
      ],
      body: ListView(
        children: state
            .map(
              (e) => CheckboxListTile(
                title: Text(e.name),
                value: e.hasBought,
                onChanged: (value) => {
                  ref
                      .read(shoppingListProvider.notifier)
                      .toggleHasBought(
                        name: e.name,
                      ),
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
