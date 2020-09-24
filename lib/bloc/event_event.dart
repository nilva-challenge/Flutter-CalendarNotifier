part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

class GetEvents extends EventEvent {
  final int eventCount;

  GetEvents(this.eventCount);
  @override
  List<Object> get props => [eventCount];
}
