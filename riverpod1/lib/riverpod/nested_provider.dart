import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod1/model/shopping_item_model.dart';
import 'package:riverpod1/riverpod/state_notifier_provider.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>(
  (ref) {
    final filterState = ref.watch(filterProvider);
    final shoppingListState = ref.watch(shoppingListProvider);

    if (filterState == FilterSpicyState.all) {
      return shoppingListState;
    }

    return shoppingListState
        .where(
          (element) => filterState == FilterSpicyState.spicy
              ? element.isSpicy
              : !element.isSpicy,
        )
        .toList();
  },
);

enum FilterSpicyState {
  notSpicy,
  spicy,
  all,
}

final filterProvider = StateProvider<FilterSpicyState>(
  (ref) => FilterSpicyState.all,
);
