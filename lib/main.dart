import 'package:crud_between_screen/list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'child_screen.dart';

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
        });
  }
}

final listProvider = StateNotifierProvider<ListNotifier, List<String>>((ref) {
  return ListNotifier();
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listProvider);
    final notifier = ref.watch(listProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext ctx, int i) {
            debugPrint(i.toString());
            return GestureDetector(
              child: Card(child: Text(list[i])),
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  ChildScreen.routeName,
                  arguments: ChildScreenArgs(key: list[i]),
                );
              },
            );
          },
          itemCount: list.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notifier.addList("item");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
