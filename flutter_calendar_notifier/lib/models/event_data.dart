import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_notifier/models/event.dart' as model;
import 'package:googleapis/calendar/v3.dart' as google;
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_calendar_notifier/constants/constants.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:provider/provider.dart';

ClientId _clientID = ClientId(clientId, '');
var _scopes = [CalendarApi.CalendarScope];

final accountCredentials = new ServiceAccountCredentials(
  clientEmail,
  _clientID,
  privateKey,
);

class EventData extends ChangeNotifier {
  int _maxResults = 8;
  List<google.Event> events = [];
  bool loading = true;

  void getEvents() async {
    AuthClient client =
        await clientViaServiceAccount(accountCredentials, _scopes);

    var calendar = google.CalendarApi(client);
    String calendarId = "primary";

    Events e = await calendar.events.list(calendarId);
    events = e.items;
    loading = false;

    // notify
    notifyListeners();
  }

  void getMoreEvents() {}

  void addNewEvent(model.Event model) async {
    // create a new google event
    google.Event event = google.Event();
    google.EventDateTime start = new google.EventDateTime();
    start.dateTime = model.startDate;
    start.timeZone = 'Asia/Tehran';

    google.EventDateTime end = new google.EventDateTime();
    end.timeZone = 'Asia/Tehran';
    end.dateTime = model.endDate;

    event.start = start;
    event.end = end;
    event.description = model.description;
    event.summary = model.name;
    if (model.repeat != null || model.repeat != '') {
      event.recurrence = [model.repeat];
    }

    // add using AuthClient
    AuthClient client =
        await clientViaServiceAccount(accountCredentials, _scopes);

    var calendar = google.CalendarApi(client);
    String calendarId = "primary";
    calendar.events.insert(event, calendarId).then((value) {
      if (value.status == "confirmed") {
        print('Event added in google calendar');
      } else {
        print("Unable to add event in google calendar");
      }
    });

    // notify
    notifyListeners();
  }
}
