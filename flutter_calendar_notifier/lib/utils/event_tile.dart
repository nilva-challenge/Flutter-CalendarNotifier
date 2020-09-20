import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;

class EventTile extends StatelessWidget {
  final calendar.Event _event;
  EventTile(this._event);

  String _makeRecurrence() {
    if (_event.recurrence == null)
      return '';
    else if (_event.recurrence.toString() == '[RRULE:FREQ=DAILY]')
      return 'Daily event!';
    else if (_event.recurrence.toString() == '[RRULE:FREQ=WEEKLY]')
      return 'Weekly event!';
    else if (_event.recurrence.toString() == '[RRULE:FREQ=MONTHLY]')
      return 'Monthly event!';
    else if (_event.recurrence.toString() == '[RRULE:FREQ=YEARLY]')
      return 'Yearly event!';
    else
      return 'unknown repeat!';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
      child: Card(
        elevation: 3.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 0),
                        child: Text(
                          _event.start.dateTime.toString() == 'null'
                              ? _event.start.dateTime.toString()
                              : _event.start.dateTime
                                  .toString()
                                  .substring(0, 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 0),
                        child: Text(
                          _event.start.dateTime.toString() == 'null'
                              ? _event.start.dateTime.toString()
                              : _event.start.dateTime
                                  .toString()
                                  .substring(0, 16),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'title: ${_event.summary}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Discretion: ${_event.description}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                _makeRecurrence(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
