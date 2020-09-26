part of 'eventcubit_cubit.dart';

abstract class EventcubitState extends Equatable {
  const EventcubitState();
}

class EventcubitInitial extends EventcubitState {
  const EventcubitInitial();

  @override
  List<Object> get props => throw UnimplementedError();
}

class EventcubitLoading extends EventcubitState {
  const EventcubitLoading();

  @override
  List<Object> get props => throw UnimplementedError();
}

class EventcubitLoaded extends EventcubitState {
  final List<EventModel> eventList;

  const EventcubitLoaded(this.eventList);

  @override
  List<Object> get props => [eventList];
}

class EventcubitError extends EventcubitState {
  final String message;

  const EventcubitError(this.message);

  @override
  List<Object> get props => [message];
}
