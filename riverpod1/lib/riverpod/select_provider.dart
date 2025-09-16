import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod1/model/shopping_item_model.dart';

class SelectNotifier extends StateNotifier<ShoppingItemModel> {
  SelectNotifier()
    : super(
        ShoppingItemModel(
          name: '김치',
          quantity: 3,
          hasBought: false,
          isSpicy: true,
        ),
      );

  toggleHasBought() {
    state = ShoppingItemModel(
      name: state.name,
      quantity: state.quantity,
      hasBought: !state.hasBought,
      isSpicy: state.isSpicy,
    );
  }

  toggleIsSpicy() {
    state = ShoppingItemModel(
      name: state.name,
      quantity: state.quantity,
      hasBought: state.hasBought,
      isSpicy: !state.isSpicy,
    );
  }
}
