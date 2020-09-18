import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as v3;

class EventListTileWidget extends StatelessWidget {
  final v3.Event event;

  const EventListTileWidget({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(event.summary ?? ''),
          subtitle: Text(event.description ?? ''),
          leading: CircleAvatar(
            child: Center(
              child: Text(
                event.recurrence?.first?.split('=')?.last ?? '',
                style: TextStyle(color: Colors.white, fontSize: 8),
              ),
            ),
          ),
          trailing: Column(
            children: [
              Text(event.start.dateTime.toString() ?? ''),
              Text(event.end.dateTime.toString() ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
