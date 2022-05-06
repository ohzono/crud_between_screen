import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListNotifier extends StateNotifier<List<String>> {
  ListNotifier() : super([]);

  void addList(String item) {
    state = [...state, "$item ${state.length}"];
  }

  void remove(String item) {
    state = [
      for (final it in state)
        if (it != item) it,
    ];
  }

  void update(String item) {
    state = [
      for (final it in state)
        if (it == item) "$item $item" else it
    ];
  }
}
