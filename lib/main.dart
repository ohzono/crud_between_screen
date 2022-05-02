import 'package:flutter/material.dart';

import 'child_screen.dart';

void main() {
  runApp(const MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _item = [];

  var _count = 0;

  void _incrementCounter() {
    setState(() {
      _item.add("item $_count");
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext ctx, int i) {
            debugPrint(i.toString());
            return GestureDetector(
              child: Card(child: Text(_item[i])),
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(
                  ChildScreen.routeName,
                  arguments: ChildScreenArgs(text: _item[i]),
                ) as String?;
                if (result != null) {
                  final int index = _item.indexOf(result);
                  setState(() {
                    if (result != _item[i]) {
                      _item[_item.indexWhere((e) => e == _item[i])] = result;
                    } else {
                      _item.removeAt(index);
                    }
                  });
                }
              },
            );
          },
          itemCount: _item.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
