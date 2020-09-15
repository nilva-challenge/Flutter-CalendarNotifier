part of 'calendar_cubit.dart';

@immutable
abstract class CalendarState {
  const CalendarState();
}

class CalendarInitialState extends CalendarState {
  const CalendarInitialState();
}

class CalendarLoadingState extends CalendarState {
  const CalendarLoadingState();
}

class AddCalendarState extends CalendarState {
  final String message;
  const AddCalendarState({this.message});
}

class GetCalendarState extends CalendarState {
  final List<EventModel> events;

  GetCalendarState({@required this.events});
}

class CalendarError extends CalendarState {
  final String message;
  const CalendarError({this.message});
}
