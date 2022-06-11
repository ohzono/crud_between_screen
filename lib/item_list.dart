import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item.dart';

class ItemListNotifier extends StateNotifier<List<ItemState>> {
  final Reader _read;
  ItemListNotifier(this._read) : super(const []);

  void addList(ItemState item) {
    state = [...state, item];
  }

  void remove(ItemState item) {
    state = [
      for (final it in state)
        if (it != item) it,
    ];
  }

  void update(ItemState item) {
    state = [
      for (final it in state)
        if (it == item) item else it
    ];
  }

  void addItemInnerList(String itemName, String innerItem) {
    ItemState targetItem =
        state.firstWhere((element) => element.name == itemName);
    ItemState t = targetItem.copyWith(
      innerItemList: [...targetItem.innerItemList, innerItem],
    );
    state = [
      for (final it in state)
        if (it.name == itemName) t else it
    ];
  }
}
