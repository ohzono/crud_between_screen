import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'grand_child_screen.dart';
import 'item.dart';
import 'main.dart';

class ChildScreen extends ConsumerWidget {
  const ChildScreen({Key? key}) : super(key: key);

  static String routeName = "/child_screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as ChildScreenArgs;
    final list = ref.watch(itemListProvider);
    final notifier = ref.read(itemListProvider.notifier);
    final ItemState item =
        list.firstWhere((element) => element.name == args.key, orElse: () {
      debugPrint("This item has deleted or replaced: ${args.key}");
      return ItemState(name: args.key.toString(), innerItemList: []);
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
                await Navigator.of(context).pushNamed(
                  GrandChildScreen.routeName,
                  arguments: GrandChildScreenArgs(
                    name: item.name,
                    addedItem: "added item ${item.innerItemList.length}",
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

class ChildScreenArgs {
  final String key;

  ChildScreenArgs({required this.key});
}
