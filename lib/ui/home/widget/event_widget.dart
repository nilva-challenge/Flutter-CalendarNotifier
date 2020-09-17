import 'package:flutter/material.dart';
import 'package:fluttercalendarnotifier/color.dart';
import 'package:googleapis/calendar/v3.dart' as Calendar;

class EventWidget extends StatelessWidget {
  final Calendar.Event event;

  const EventWidget({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.summary ?? '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 8),
            Text(
              event.description ?? '',
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Row(children: [
              Text(
                'Start time:  ',
                style: TextStyle(color: blue),
              ),
              Text(event.start.dateTime.toString() ?? ''),
            ]),
            SizedBox(height: 8),
            Row(children: [
              Text(
                'End time:  ',
                style: TextStyle(color: blue),
              ),
              Text(event.end.dateTime.toString() ?? ''),
            ]),
            SizedBox(height: 8),
            Row(children: [
              Text(
                'Reapeat:  ',
                style: TextStyle(color: blue),
              ),
              Text(event.recurrence?.first?.split('=')?.last ?? '')
            ]),
          ],
        ),
      ),
    );
  }
}
