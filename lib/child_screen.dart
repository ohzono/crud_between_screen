import 'package:flutter/material.dart';

class ChildScreen extends StatelessWidget {
  const ChildScreen({Key? key}) : super(key: key);

  static String routeName = "/child_screen";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ChildScreenArgs;
    return GestureDetector(
      child: Text("delete ${args.text}"),
      onTap: () {
        Navigator.pop(context, args.text);
      },
      onLongPress: () {
        Navigator.pop(context, args.text + args.text);
      },
    );
  }
}

class ChildScreenArgs {
  final String text;

  ChildScreenArgs({required this.text});
}
