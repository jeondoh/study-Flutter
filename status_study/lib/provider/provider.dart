import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_study/provider/state_notifier_provider.dart';

import '../model/shopping_item_model.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>(
  (ref) {
    final filterState = ref.watch(filterProvider);
    final shoppingListState = ref.watch(shoppingListProvider);

    if (filterState == FilterState.all) {
      return shoppingListState;
    }

    return shoppingListState
        .where((element) => filterState == FilterState.spicy
            ? element.isSpicy
            : !element.isSpicy)
        .toList();
  },
);

enum FilterState {
  all,
  notSpicy,
  spicy,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
