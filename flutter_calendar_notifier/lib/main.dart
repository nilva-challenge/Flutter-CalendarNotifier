import 'package:flutter/material.dart';
import 'package:flutter_calendar_notifier/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calendar_notifier/models/event_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventData(),
      child: MaterialApp(
        title: 'Flutter Calendar Notifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
