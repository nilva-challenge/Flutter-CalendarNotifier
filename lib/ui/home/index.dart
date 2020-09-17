import 'package:flutter/material.dart';
import 'package:fluttercalendarnotifier/bloc/event_bloc.dart';
import 'package:fluttercalendarnotifier/ui/add_event/index.dart';
import 'package:fluttercalendarnotifier/ui/home/widget/event_widget.dart';
import 'package:googleapis/calendar/v3.dart' as c;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final eventBloc = EventBloc();

  @override
  void initState() {
    super.initState();
    eventBloc.getCalendarEvents();
  }

  @override
  void dispose() {
    eventBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEventScreen(
                        eventBloc: eventBloc,
                      )))),
      body: StreamBuilder<List<c.Event>>(
        stream: eventBloc.eventsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return EventWidget(event: snapshot.data[index]);
                    },
                  )
                : Container();
          } else {
            return _buildLoader();
          }
        },
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 45,
          height: 45,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
