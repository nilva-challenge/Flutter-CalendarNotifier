import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/cubit/calendar_cubit.dart';
import 'package:flutter_calendar_app/models/mEvent.dart';
import 'package:flutter_calendar_app/screens/add_event_screen.dart';
import 'package:flutter_calendar_app/widgets/main_screen_widgets/appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_app/widgets/main_screen_widgets/body_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    context.bloc<CalendarCubit>().getEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.1,
        ),
        child: AppbarWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEventClick,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BodyWidget(),
      // BodyWidget(),
    );
  }

  void _addEventClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventScreen(),
      ),
    ).then((value) {
      if (value is EventModel) context.bloc<CalendarCubit>().addEvent(value);
    });
  }
}
