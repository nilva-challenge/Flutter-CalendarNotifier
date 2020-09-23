part of 'calender_bloc.dart';

enum CalenderErrorType {
  load,
  submit,
}

abstract class CalenderState extends Equatable {
  const CalenderState();

  @override
  List<Object> get props => [];
}

class CalenderInitial extends CalenderState {}

class CalenderLoaded extends CalenderState {
  final List<EventEntity> events;
  CalenderLoaded(this.events);
}

class CalenderLoading extends CalenderState {}

class CalenderEventSubmitInProgress extends CalenderState {}

class CalenderEventSubmitSuccess extends CalenderState {}

class CalenderError extends CalenderState {
  final String errMsg;
  final CalenderErrorType errType;
  CalenderError({
    @required this.errMsg,
    @required this.errType,
  });
}
