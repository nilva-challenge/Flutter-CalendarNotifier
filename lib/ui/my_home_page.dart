import 'package:calendar_challenge/ui/add_event_screen.dart';
import 'package:calendar_challenge/ui/event_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:calendar_challenge/bloc.dart';
import 'package:googleapis/calendar/v3.dart' as v3;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      appBar: AppBar(
        title: Text('Calendar Challenge'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                context: context,
                builder: (builder) {
                  return AddEventScreen(
                    eventBloc: eventBloc,
                  );
                });
          }),
      body: Center(
        child: StreamBuilder<List<v3.Event>>(
            stream: eventBloc.eventsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return EventListTileWidget(event: snapshot.data[index]);
                  },
                );
              } else {
                return Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }
}
