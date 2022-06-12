import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'item_state.dart';

class ItemRepository {
  void save(List<ItemState> list) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("test", jsonEncode(list));
  }

  Future<List<ItemState>> fetchAll() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String? j = _preferences.getString("test");
    if (j == null) {
      return [];
    } else {
      return (json.decode(j) as List)
          .map((e) => ItemState.fromJson(e))
          .toList();
    }
  }
}
