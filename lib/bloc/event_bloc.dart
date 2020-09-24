import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_calendar_notifier/components/event_list_view.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final MyEventListView myEventListView;

  EventBloc(this.myEventListView) : super(EventInitial());

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    yield EventLoading();
    if (event is GetEvents) {
      try {
        // TODO: get events from Google calendar
        yield EventLoaded(myEventListView);
      } on Exception {
        yield EventError('Something went worng');
      }
    }
  }
}
