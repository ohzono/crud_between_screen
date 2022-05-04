import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  late List<String> _list;

  ListProvider() {
    _list = [];
  }

  List<String> get() {
    return _list;
  }

  void addList(String item) {
    _list.add("item ${_list.length}");
    notifyListeners();
  }

  void remove(String item) {
    _list.remove(item);
    notifyListeners();
  }

  void update(String item) {
    _list[_list.indexWhere((element) => element == item)] = "$item $item";
    notifyListeners();
  }
}
