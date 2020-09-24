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
  @override
  List<Object> get props => [];
}

class EventLoaded extends EventState {
  final MyEventListView myEventListView;

  const EventLoaded(this.myEventListView);
  @override
  List<Object> get props => [myEventListView];
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);
  @override
  List<Object> get props => [message];
}
