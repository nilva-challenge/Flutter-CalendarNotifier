import 'package:calendar_challenge/consts.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:async';
import 'dart:developer';

// https://stackoverflow.com/questions/49414279/using-dart-and-flutter-with-google-calendar-api-to-get-a-list-of-events-on-the-a
// https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern#toc-anchor-010
ClientId _clientID = ClientId(clientId, '');
var _scopes = [CalendarApi.CalendarScope];

final accountCredentials = ServiceAccountCredentials(
  clientEmail,
  _clientID,
  privateKey,
);

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
    print(_event);
    _eventsController.sink.add(_event);
  }

// https://medium.com/flutter-community/flutter-use-google-calendar-api-adding-the-events-to-calendar-3d8fcb008493
  addEvent(title, description, startTime, endTime, repeat) async {
    Event event = Event();

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
