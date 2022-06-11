import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class GrandChildScreen extends ConsumerWidget {
  const GrandChildScreen({
    Key? key,
    required final this.name,
    required final this.addedItem,
  }) : super(key: key);
  final String name;
  final String addedItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(itemListProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ElevatedButton(
          child: const Text("add inner list"),
          onPressed: () {
            notifier.addItemInnerList(name, addedItem);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
