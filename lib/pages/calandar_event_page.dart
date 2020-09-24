import 'package:flutter/material.dart';
import 'package:flutter_calendar_notifier/components/floating_action_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarEventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarEventPageState();
}

class _CalendarEventPageState extends State<CalendarEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Events',
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SfCalendar(),
      ),
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}
