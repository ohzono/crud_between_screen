import 'package:crud_between_screen/item_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'child_screen.dart';
import 'grand_child_screen.dart';
import 'item.dart';

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, List<ItemState>>((ref) {
  return ItemListNotifier(ref.read);
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
        routes: {
          ChildScreen.routeName: (context) => const ChildScreen(),
          GrandChildScreen.routeName: (context) => const GrandChildScreen(),
        });
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(itemListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            return ListView.builder(
              itemBuilder: (BuildContext ctx, int i) {
                debugPrint(i.toString());
                return GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(list[i].name),
                    ),
                  ),
                  onTap: () async {
                    await Navigator.of(context).pushNamed(
                      ChildScreen.routeName,
                      arguments: ChildScreenArgs(key: list[i].name),
                    );
                  },
                );
              },
              itemCount: list.length,
            );
          },
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () {
            ref.read(itemListProvider.notifier).addList(
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
