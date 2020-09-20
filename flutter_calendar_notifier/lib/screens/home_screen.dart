import 'package:flutter/material.dart';
import 'package:flutter_calendar_notifier/models/event_data.dart';
import 'package:flutter_calendar_notifier/utils/app_bar.dart';
import 'package:flutter_calendar_notifier/utils/floating_action_button.dart';
import 'package:flutter_calendar_notifier/utils/event_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
            MediaQuery.of(context).size.width, 60, 'Calendar Notifier'),
        floatingActionButton: MyFloatingActionButton(),
        body: EventsList(),
      ),
    );
  }
}
