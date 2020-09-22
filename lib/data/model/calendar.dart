import 'package:flutter_calendar_notifier/configs/credentials.dart';
import 'package:googleapis/calendar/v3.dart';

class Calendar {
  /// We use [CalendarScope] to creeate events.
  static const _scopes = const [CalendarApi.CalendarScope];
  var credential = Credentials.credentials;
}
