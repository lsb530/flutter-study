import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod1/model/shopping_item_model.dart';

final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
      (ref) => ShoppingListNotifier(),
    );

class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  /// 최초 상태값을 지정할 수 있음
  // ShoppingListNotifier(super.state);
  // ShoppingListNotifier([]]);
  ShoppingListNotifier()
    : super([
        ShoppingItemModel(
          name: '김치',
          quantity: 3,
          hasBought: false,
          isSpicy: true,
        ),
        ShoppingItemModel(
          name: '라면',
          quantity: 5,
          hasBought: false,
          isSpicy: true,
        ),
        ShoppingItemModel(
          name: '삼겹살',
          quantity: 10,
          hasBought: false,
          isSpicy: false,
        ),
        ShoppingItemModel(
          name: '수박',
          quantity: 2,
          hasBought: false,
          isSpicy: false,
        ),
        ShoppingItemModel(
          name: '카스테라',
          quantity: 5,
          hasBought: false,
          isSpicy: false,
        ),
      ]);

  void toggleHasBought({required String name}) {
    state = state
        .map(
          (e) => e.name == name
              ? ShoppingItemModel(
                  name: e.name,
                  quantity: e.quantity,
                  hasBought: !e.hasBought,
                  isSpicy: e.isSpicy,
                )
              : e,
        )
        .toList();
  }
}
