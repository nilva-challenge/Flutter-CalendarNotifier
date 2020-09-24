import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final onPressed;

  const MyFloatingActionButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: onPressed,
    );
  }
}
