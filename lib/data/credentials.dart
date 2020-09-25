import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_calendar_notifier/data/model/event_model.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  static const _scopes = const [CalendarApi.CalendarScope];
  List<EventModel> eventList = new List<EventModel>();

  //* Get Events Authentication
  final _clientID = new ClientId(
      "31116624588-n2sbace1ec773jgk5l5j6qfgovorfnkd.apps.googleusercontent.com",
      "");

  Future<List<EventModel>> getEvents() async {
    await clientViaUserConsent(_clientID, _scopes, prompt)
        .then((AuthClient client) {
      var calendar = CalendarApi(client);

      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";

      calendar.events.list(calendarId).then((Events events) async {
        print('EVENTS COUNT: ' + events.items.length.toString());
        events.items.forEach((Event event) {
          eventList.add(new EventModel(
            eventName: event.summary,
            eventDesciption: event.description,
            dueDate: event.start.date,
          ));
          print("EVENT SUMMARY" + event.summary);
          print("EVENT TIMEZONE: " + event.created.toString());
          print("EVENT CREATOR: " + event.creator.email);
        });
      });
    });
    print('EVENT LIST LENGTH: ' + eventList.length.toString());
    return eventList;
  }

//* Insert Event
  insert(title, startTime, endTime, dueDate) {
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);

      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";

      calendar.events.list(calendarId).then((Events events) async {
        print('EVENTS COUNT: ' + events.items.length.toString());
        events.items.forEach((Event event) {
          eventList.add(new EventModel(
            eventName: event.summary,
            eventDesciption: event.description,
            dueDate: event.start.date,
          ));
          print("EVENT SUMMARY" + event.summary);
          print("EVENT TIMEZONE: " + event.created.toString());
          print("EVENT CREATOR: " + event.creator.email);
        });
      });

      Event event = Event(); // Create object of event

      event.summary = title;

      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+03:30";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+03:30";
      end.dateTime = endTime;
      event.end = end;

      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("EVENT_ADDED${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
