import 'item.dart';

class ItemRepository {
  List<ItemState> _list = [];
  void save(List<ItemState> list) {
    _list = list;
  }

  List<ItemState> fetchAll() {
    return _list;
  }
}
