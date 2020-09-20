import 'package:flutter/material.dart';
import 'package:flutter_calendar_notifier/models/event_data.dart';
import 'package:provider/provider.dart';

import 'event_tile.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<EventData>(context).loading) {
      Provider.of<EventData>(context).getEvents();
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return EventTile(Provider.of<EventData>(context).events[index]);
        },
        itemCount: Provider.of<EventData>(context).events.length,
      );
    }
  }
}
