import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class GrandChildScreen extends ConsumerWidget {
  const GrandChildScreen({Key? key}) : super(key: key);

  static String routeName = "/grand_child_screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args =
        ModalRoute.of(context)?.settings.arguments as GrandChildScreenArgs;
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
            notifier.addItemInnerList(args.name, args.addedItem);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class GrandChildScreenArgs {
  final String name;
  final String addedItem;

  GrandChildScreenArgs({required this.name, required this.addedItem});
}
