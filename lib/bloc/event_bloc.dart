import 'dart:async';
import 'dart:developer';

import 'package:fluttercalendarnotifier/value.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

//get Service Account Credentials
ClientId _clientID = ClientId(clientId, '');

final accountCredentials = new ServiceAccountCredentials(
  clientEmail,
  _clientID,
  privateKey,
);

//defines the scopes for the calendar api
var _scopes = [CalendarApi.CalendarScope];

class EventBloc {
  List<Event> _event = [];

  final StreamController<List<Event>> _eventsController =
      StreamController<List<Event>>();

  Stream<List<Event>> get eventsStream => _eventsController.stream;

  void getCalendarEvents() async {
    AuthClient client =
        await clientViaServiceAccount(accountCredentials, _scopes);
    var calendar = CalendarApi(client);
    var events = await calendar.events.list(calendarId);
    _event.clear();
    _event.addAll(events.items);
    _eventsController.sink.add(_event);
  }

  addEvent(title, description, startTime, endTime, repeat) async {
    Event event = Event(); // Create object of event

    event.summary = title;
    event.description = description;

    EventDateTime start = EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+05:00";
    event.start = start;

    EventDateTime end = EventDateTime();
    end.timeZone = "GMT+05:00";
    end.dateTime = endTime;
    event.end = end;

    event.recurrence = [
      'RRULE:FREQ=${repeat.toUpperCase()}',
    ];

    try {
      AuthClient client =
          await clientViaServiceAccount(accountCredentials, _scopes);
      var calendar = CalendarApi(client);
      calendar.events.insert(event, calendarId).then((value) {
        print("ADDEDDD_________________${value.status}");
        if (value.status == "confirmed") {
          log('Event added in google calendar');
          getCalendarEvents();
        } else {
          log("Unable to add event in google calendar");
        }
      });
    } catch (e) {
      log('Error creating event $e');
    }
  }

  void dispose() {
    _eventsController.close();
    _event.clear();
  }
}
