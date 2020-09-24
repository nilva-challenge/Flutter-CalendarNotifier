import 'package:flutter/material.dart';
import 'package:flutter_calendar_notifier/pages/calandar_event_page.dart';
import 'package:flutter_calendar_notifier/pages/calendar_page.dart';

import 'data/credentials.dart';

void main() {
  runApp(MyApp());
  Credentials().getCalendarEvents();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalendarNotifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalendarEventPage(),
    );
  }
}
