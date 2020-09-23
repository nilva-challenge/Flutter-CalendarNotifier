part of 'calender_bloc.dart';

abstract class CalenderEvent extends Equatable {
  const CalenderEvent();

  @override
  List<Object> get props => [];
}

class GetCalenderEvents extends CalenderEvent {}

class SubmitCalenderEvent extends CalenderEvent {
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime dueDate;
  final RepeatMode recurrence;

  SubmitCalenderEvent({
    @required this.description,
    @required this.dueDate,
    @required this.name,
    this.recurrence,
    this.startDate,
  });
}
