import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../data/credentials.dart';
import '../data/model/event_model.dart';
import 'circular_progress_indicator.dart';

class MyEventListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CalendarClient().getEvents(),
        builder: (context, snapshot) {
          List<EventModel> eventsList = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: eventsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.calendar_today_rounded),
                    title: eventsList[index].eventName != null
                        ? Text(eventsList[index].eventName)
                        : Text('No Title'),
                    subtitle: eventsList[index].eventDesciption != null
                        ? Text(eventsList[index].eventDesciption)
                        : Text('No Description'),
                    trailing: eventsList[index].dueDate != null
                        ? Expanded(
                            child: Text(
                              eventsList[index].dueDate.toString(),
                            ),
                          )
                        : Text('-'),
                  );
                });
          } else {
            return MyCircularProgressIndicator();
          }
        });
  }
}
