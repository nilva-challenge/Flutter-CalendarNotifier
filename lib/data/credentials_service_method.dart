import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

class Credentials {
  final _credentials = new ServiceAccountCredentials.fromJson(r'''
{
  "private_key_id": "_",
  "private_key": ""_,
  "client_email": "_",
  "client_id": "_",
  "type": "service_account"
}
''');

  static const _SCOPES = const [CalendarApi.CalendarScope];

  void getCalendarEvents() async {
    clientViaServiceAccount(_credentials, _SCOPES).then((client) {
      var calendar = new CalendarApi(client);

      Event event = Event(); // Create object of event
      event.summary = 'Test'; //Setting summary of object

      EventDateTime start = new EventDateTime(); //Setting start time
      start.dateTime = DateTime.now().add(new Duration(days: 5));
      start.timeZone = "GMT+03:30";
      event.start = start;

      EventDateTime end = new EventDateTime(); //setting end time
      end.timeZone = "GMT+03:30";
      end.dateTime = DateTime.now().add(new Duration(days: 10));
      event.end = end;

      //* Add event
      calendar.events.insert(event, 'primary').then((value) {
        print("EVENT STATUS" + value.status);
      });

      var calEvents = calendar.events.list("primary");
      calEvents.then((Events events) {
        print('EVENTS COUNT: ' + events.items.length.toString());
        events.items.forEach((Event event) {
          print("EVENT SUMMARY" + event.summary);
          print("EVENT TIMEZONE: " + event.created.toString());
          print("EVENT CREATOR: " + event.creator.email);
        });
      });
    });
  }
}
