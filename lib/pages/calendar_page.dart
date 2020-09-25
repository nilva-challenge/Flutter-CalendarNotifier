import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/event_list_view.dart';
import '../components/floating_action_button.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Appbar
      appBar: AppBar(
        title: Text('CalendarNotifier'),
        centerTitle: true,
      ),

      //* Body
      // TODO: Implement BlocBuilder
      body: MyEventListView(),
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}
