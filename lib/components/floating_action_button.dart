import 'package:flutter/material.dart';

import '../data/credentials.dart';

class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        CalendarClient().insert(
          "TITLE",
          DateTime.now(),
          DateTime.now().add(Duration(days: 1)),
          DateTime.now().add(Duration(hours: 2)),
        );
      },
    );
  }
}
