import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalandarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalandarPageState();
}

class _CalandarPageState extends State<CalandarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //? Appbar
      appBar: AppBar(
        title: Text('CalendarNotifier'),
        centerTitle: true,
      ),

      //? Body
      body:
          // TODO: Check connection first
          null,
    );
  }
}
