import 'package:connectivity/connectivity.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/event_entity.dart';
import '../models/event_entity_model.dart';

const _scopes = const [CalendarApi.CalendarScope];
const String _calendarId = "primary";
const String timeZone = "GMT+05:00";

class CalenderRemoteSource {
  final ClientId client;
  AutoRefreshingAuthClient _cachedAuthenticatedClient;

  CalenderRemoteSource(this.client);

  Future<List<EventEntityModel>> getEvents() async {
    if ((await Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      throw NetworkException();
    }
    var authenticatedClient = await _authenticate();
    try {
      var calendar = CalendarApi(authenticatedClient);
      var events = await calendar.events.list(_calendarId);
      return events.items
          .map<EventEntityModel>(
            (e) => EventEntityModel(
              id: e.id,
              description: e.description,
              dueDate: e.end.dateTime,
              name: e.summary,
              recurrenceRaw:
                  e.recurrence.length > 0 ? e.recurrence.first : null,
              startDate: e.start.dateTime,
            ),
          )
          .toList();
    } catch (err) {
      throw ApiException();
    }
  }

  Future<NoValue> submitEvent(EventEntityModel eventModel) async {
    if ((await Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      throw NetworkException();
    }
    var authenticatedClient = await _authenticate();
    try {
      var calendar = CalendarApi(authenticatedClient);
      Event event = Event(); // Create object of event
      event.summary = eventModel.name; //Setting summary of object

      EventDateTime start = new EventDateTime(); //Setting start time
      start.dateTime = eventModel.startDate;
      start.timeZone = timeZone;
      event.start = start;

      EventDateTime end = new EventDateTime(); //setting end time
      end.timeZone = timeZone;
      end.dateTime = eventModel.dueDate;
      event.end = end;

      event.recurrence = eventModel.recurrence == RepeatMode.none
          ? []
          : [eventModel.recurrenceRaw];
      event.description = eventModel.description;
      await calendar.events.insert(event, _calendarId);
      return NoValue();
    } catch (err) {
      throw ApiException();
    }
  }

  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw AuthException();
    }
  }

  Future<AutoRefreshingAuthClient> _authenticate() async {
    if (client == null) throw AuthException();
    var authenticatedClient;
    try {
      authenticatedClient = _cachedAuthenticatedClient ??
          await clientViaUserConsent(client, _scopes, prompt);
    } catch (err) {
      throw AuthException();
    }
    return authenticatedClient;
  }
}
