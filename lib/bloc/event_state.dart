part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {
  const EventInitial();
}

class EventLoading extends EventState {
  const EventLoading();
}

class EventLoaded extends EventState {
  final List<EventModel> eventList;

  const EventLoaded(this.eventList);
  @override
  List<Object> get props => [eventList];
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);
  @override
  List<Object> get props => [message];
}
