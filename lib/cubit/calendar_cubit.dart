import 'package:bloc/bloc.dart';
import 'package:flutter_calendar_app/const.dart';
import 'package:flutter_calendar_app/models/mEvent.dart';
import 'package:flutter_calendar_app/utilities.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:meta/meta.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  List<EventModel> _events = [];

  ServiceAccountCredentials _clientCredentials;

  ClientId _clientID = ClientId(kClientIdIdentifier, '');

  CalendarCubit() : super(CalendarInitialState()) {
    _clientCredentials = ServiceAccountCredentials(
      kCLIENT_EMAIL,
      _clientID,
      kPRIVATE_KEY,
    );
  }

  void addEvent(EventModel _event) async {
    emit(CalendarLoadingState());

    Event event = Event();
    event.summary = _event.title;
    event.description = _event.description;

    EventDateTime start = EventDateTime();
    start.dateTime = DateTime.parse(_event.startDate);
    start.timeZone = "GMT+05:00"; //GMT+04:30 for Iran
    event.start = start;

    EventDateTime end = EventDateTime();
    end.timeZone = "GMT+05:00";
    end.dateTime = DateTime.parse(_event.endDate);
    event.end = end;

    if (_event.repeat != 'Does not repeat') {
      String _endDate = Utilities.createDateField(end.dateTime.toString());
      event.recurrence = [
        'RRULE:FREQ=${_event.repeat.toUpperCase()};UNTIL=$_endDate',
      ];
    }

    try {
      AuthClient client =
          await clientViaServiceAccount(_clientCredentials, kScopes);

      CalendarApi calendar = CalendarApi(client);

      Event result = await calendar.events.insert(event, kCalendarId);
      if (result.status == 'confirmed') {
        emit(
          AddCalendarState(
            message: 'Event added successfully in google calendar',
          ),
        );
      } else {
        emit(
          CalendarError(
            message: 'Can\'t add event at this time. please try again later',
          ),
        );
      }

      client.close();
    } catch (e) {
      emit(
        CalendarError(
            message: 'Can\'t add event at this time. please try again later'),
      );
    }
  }

  void getEvent() async {
    _events.clear();

    emit(CalendarLoadingState());

    AuthClient client =
        await clientViaServiceAccount(_clientCredentials, kScopes);

    CalendarApi calendar = CalendarApi(client);
    var events = await calendar.events.list(kCalendarId);
    events.items.forEach((Event event) {
      _events.add(
        EventModel(
          id: event.id,
          title: event.summary,
          description: event.description,
          repeat: event.recurrence != null
              ? event.recurrence[0]
              : 'Does not repeat',
          startDate:
              Utilities.formatDateTimeDisplay(event.start.dateTime.toString()),
          endDate:
              Utilities.formatDateTimeDisplay(event.end.dateTime.toString()),
        ),
      );
    });

    client.close();

    emit(GetCalendarState(events: _events));
  }

  void removeEvents() async {
    emit(CalendarLoadingState());

    AuthClient client =
        await clientViaServiceAccount(_clientCredentials, kScopes);

    CalendarApi calendar = CalendarApi(client);
    var events = await calendar.events.list(kCalendarId);
    List<String> _list = [];
    events.items.forEach((Event event) {
      _list.add(event.id);
    });

    for (var data in _list) {
      await calendar.events.delete(kCalendarId, data);
    }
    _events.clear();

    client.close();

    emit(GetCalendarState(events: _events));
  }

  void removeEvent(String _eventId) async {
    emit(CalendarLoadingState());

    AuthClient client = await clientViaServiceAccount(
      _clientCredentials,
      kScopes,
    );

    CalendarApi calendar = CalendarApi(client);
    calendar.events.delete(kCalendarId, _eventId);
    _events.removeWhere((element) => element.id == _eventId);

    client.close();

    emit(GetCalendarState(
      events: _events,
    ));
  }

  void searchEvent(String _search) {
    List<EventModel> _localSpecialty = _events;

    if (_search != '') {
      RegExp _reg = RegExp(r'^' + _search, caseSensitive: false);
      List<EventModel> res = _localSpecialty
          .where((element) => _reg.hasMatch(element.title))
          .toList();

      if (res.length > 0) {
        emit(GetCalendarState(events: res));
      }
    } else {
      emit(GetCalendarState(events: _events));
    }
  }
}
