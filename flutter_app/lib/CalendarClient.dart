import 'dart:developer';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Cal_Event.dart';

class CalendarClient {
  static const _scopes = const [CalendarApi.CalendarScope];

  insert(Cal_Event calEvent) {
    var _clientID = new ClientId("544079133331-q7lanipdojl6pnocedchndbo20rjs0nu.apps.googleusercontent.com", "");
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      String calendarId = "primary";
       Event event = createEvent(calEvent);

      try {
        calendar.events.insert(event, calendarId).then((value) {
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


  Event createEvent(Cal_Event calEvent) {
    Event event = Event();

    event.summary = calEvent.name;
    event.description = calEvent.description;

    if(calEvent.repeat != null)
      event.recurrence = [calEvent.repeat];

    EventDateTime start = new EventDateTime();
    start.dateTime = calEvent.startTime;
    start.timeZone = "GMT+03:30";
    event.start = start;

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+03:30";
    end.dateTime = calEvent.endTime;
    event.end = end;

    return event;
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
