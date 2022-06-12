import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'grand_child_screen.dart';
import 'item_state.dart';
import 'main.dart';

class ChildScreen extends ConsumerWidget {
  const ChildScreen({
    Key? key,
    required final this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(itemListNotifier);
    final notifier = ref.read(itemListNotifier.notifier);
    final ItemState item =
        list.firstWhere((element) => element.name == name, orElse: () {
      debugPrint("This item has deleted or replaced: $name");
      return ItemState(name: name, innerItemList: []);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            GestureDetector(
              child: Text("delete $item"),
              onTap: () {
                notifier.remove(item);
                Navigator.pop(context);
              },
              onLongPress: () {
                notifier.update(item);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              child: const Text("add inner list"),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GrandChildScreen(
                      name: item.name,
                      addedItem: "added item ${item.innerItemList.length}",
                    ),
                  ),
                );
              },
            ),
            for (var i in item.innerItemList)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Text(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
