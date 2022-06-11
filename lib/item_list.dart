import 'package:crud_between_screen/item_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item.dart';

class ItemListNotifier extends StateNotifier<List<ItemState>> {
  ItemListNotifier({
    required this.itemRepository,
  }) : super(const []);
  final ItemRepository itemRepository;

  void addList(ItemState item) {
    state = [...itemRepository.fetchAll(), item];
    itemRepository.save(state);
  }

  void remove(ItemState item) {
    state = [
      for (final it in itemRepository.fetchAll())
        if (it != item) it,
    ];
    itemRepository.save(state);
  }

  void update(ItemState item) {
    state = [
      for (final it in itemRepository.fetchAll())
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
      for (final it in itemRepository.fetchAll())
        if (it.name == itemName) t else it
    ];
    itemRepository.save(state);
  }
}
