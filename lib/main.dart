import 'package:crud_between_screen/item_list.dart';
import 'package:crud_between_screen/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'child_screen.dart';
import 'item_state.dart';

final repositoryProvider = Provider((ref) => ItemRepository());

final itemListNotifier =
    StateNotifierProvider<ItemListNotifier, List<ItemState>>((ref) {
  final ItemRepository repo = ref.read(repositoryProvider);
  ItemListNotifier notifier = ItemListNotifier(
    itemRepository: repo,
  );

  notifier.init();
  return notifier;
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Testing between screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(itemListNotifier);
    final notifier = ref.watch(itemListNotifier.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            return ListView(
              children: list
                  .map(
                    (ItemState e) => GestureDetector(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text(e.name),
                        ),
                      ),
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChildScreen(name: e.name),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () {
            notifier.addList(
              ItemState(
                name: "item ${list.length}",
                innerItemList: [],
              ),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
