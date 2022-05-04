import 'package:crud_between_screen/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChildScreen extends StatelessWidget {
  const ChildScreen({Key? key}) : super(key: key);

  static String routeName = "/child_screen";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ChildScreenArgs;
    ListProvider list = Provider.of<ListProvider>(context);
    final String item = list.get().firstWhere((element) => element == args.key);
    return GestureDetector(
      child: Text("delete $item"),
      onTap: () {
        list.remove(item);
        Navigator.pop(context);
      },
      onLongPress: () {
        list.update(item);
        Navigator.pop(context);
      },
    );
  }
}

class ChildScreenArgs {
  final String key;

  ChildScreenArgs({required this.key});
}
