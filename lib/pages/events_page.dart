import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ?Appbar
      appBar: AppBar(
        title: Text('CalendarNotifier'),
        centerTitle: true,
      ),

      // ?Body
      body:
          // TODO: Check connection first
          null,
    );
  }
}
