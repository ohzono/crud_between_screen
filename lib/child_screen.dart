import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class ChildScreen extends ConsumerWidget {
  const ChildScreen({Key? key}) : super(key: key);

  static String routeName = "/child_screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as ChildScreenArgs;
    final list = ref.watch(listProvider);
    final notifier = ref.watch(listProvider.notifier);
    final String item =
        list.firstWhere((element) => element == args.key, orElse: () {
      debugPrint("This item has deleted or replaced: ${args.key}");
      return "";
    });
    return GestureDetector(
      child: Text("delete $item"),
      onTap: () {
        notifier.remove(item);
        Navigator.pop(context);
      },
      onLongPress: () {
        notifier.update(item);
        Navigator.pop(context);
      },
    );
  }
}

class ChildScreenArgs {
  final String key;

  ChildScreenArgs({required this.key});
}
