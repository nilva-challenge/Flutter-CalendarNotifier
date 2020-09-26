import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/credentials.dart';
import '../data/model/event_model.dart';

part 'eventcubit_state.dart';

class EventcubitCubit extends Cubit<EventcubitState> {
  final CalendarClient calendarClient;

  EventcubitCubit(this.calendarClient) : super(EventcubitInitial());

  Future<void> getEventCubit() async {
    try {
      emit(EventcubitLoading());
      final event = await calendarClient.getEvents();
      emit(EventcubitLoaded(event));
    } on Exception {
      emit(EventcubitError('Something went wrong'));
    }
  }
}
