part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

class GetEvents extends EventEvent {
  final EventModel eventModel;

  GetEvents(this.eventModel);
  @override
  List<Object> get props => [eventModel];
}
