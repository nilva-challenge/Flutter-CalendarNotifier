import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/credentials.dart';
import '../data/model/event_model.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final CalendarClient calendarClient;

  EventBloc(this.calendarClient) : super(EventInitial());

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    yield EventInitial();
    if (event is GetEvents) {
      yield EventLoading();
      calendarClient.getEvents();
      yield EventLoaded(calendarClient.eventList);
    } else {
      EventError('Something went wrong');
    }
  }
}
