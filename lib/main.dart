import 'package:crud_between_screen/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'child_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListProvider>(
          create: (context) => ListProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'CRUD Testing between screen',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
          routes: {
            ChildScreen.routeName: (context) => const ChildScreen(),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer<ListProvider>(builder: (context, model, _) {
          return ListView.builder(
            itemBuilder: (BuildContext ctx, int i) {
              debugPrint(i.toString());
              return GestureDetector(
                child: Card(child: Text(model.get()[i])),
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    ChildScreen.routeName,
                    arguments: ChildScreenArgs(key: model.get()[i]),
                  );
                },
              );
            },
            itemCount: model.get().length,
          );
        }),
      ),
      floatingActionButton:
          Consumer<ListProvider>(builder: (context, model, _) {
        return FloatingActionButton(
          onPressed: () {
            model.addList("item");
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ); // This trailing comma makes auto-formatting nicer for build methods.
      }),
    );
  }
}
