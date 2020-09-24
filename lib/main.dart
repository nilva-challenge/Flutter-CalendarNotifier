import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_notifier/bloc/event_bloc.dart';
import 'package:flutter_calendar_notifier/components/event_list_view.dart';
import 'package:flutter_calendar_notifier/pages/calendar_page.dart';
import 'package:flutter_calendar_notifier/data/credentials.dart';

import 'data/credentials_service_method.dart';

void main() {
  runApp(MyApp());
  // Credentials().getCalendarEvents();
  CalendarClient().insert(
      "TITLE",
      DateTime.now(),
      DateTime.now().add(
        Duration(days: 1),
      ));
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
      home: BlocProvider(
        create: (context) => EventBloc(
          MyEventListView(),
        ),
        child: CalendarPage(),
      ),
    );
  }
}
