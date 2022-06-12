import 'package:crud_between_screen/item_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item_state.dart';

class ItemListNotifier extends StateNotifier<List<ItemState>> {
  ItemListNotifier({
    required this.itemRepository,
  }) : super(const []);
  final ItemRepository itemRepository;

  Future<void> init() async {
    state = await itemRepository.fetchAll();
  }

  void addList(ItemState item) {
    state = [...state, item];
    itemRepository.save(state);
  }

  void remove(ItemState item) {
    state = [
      for (final it in state)
        if (it != item) it,
    ];
    itemRepository.save(state);
  }

  void update(ItemState item) {
    state = [
      for (final it in state)
        if (it == item) item else it
    ];
    itemRepository.save(state);
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
    itemRepository.save(state);
  }
}
