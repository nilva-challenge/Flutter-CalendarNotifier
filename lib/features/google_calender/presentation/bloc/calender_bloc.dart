import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_calender/core/presentation/event_entity_convertor.dart';
import 'package:flutter_calender/core/usecases/usecase.dart';
import 'package:flutter_calender/features/google_calender/domain/repositories/event_entity_repository.dart';
import 'package:flutter_calender/features/google_calender/domain/usecases/get_event_entities.dart';
import 'package:flutter_calender/features/google_calender/domain/usecases/submit_event_entity.dart';
import 'package:meta/meta.dart';
import 'package:flutter_calender/features/google_calender/domain/entities/event_entity.dart';

part 'calender_event.dart';
part 'calender_state.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  final GetEventEntities getEvents;
  final SubmitEventEntity submitEvent;
  final EventEntityConvertor eventConvertor;
  CalenderBloc({
    @required this.getEvents,
    @required this.submitEvent,
    @required this.eventConvertor,
  }) : super(CalenderInitial());

  @override
  Stream<CalenderState> mapEventToState(
    CalenderEvent event,
  ) async* {
    if (event is GetCalenderEvents) {
      yield CalenderLoading();
      var loadOutCome = await getEvents(NoParams());
      loadOutCome.fold((l) async* {
        yield CalenderError(errMsg: '', errType: CalenderErrorType.load);
      }, (r) async* {
        yield CalenderLoaded(r);
      });
    }
    if (event is SubmitCalenderEvent) {
      var convertedValue = eventConvertor.parseEvent(
        description: event.description,
        dueDate: event.dueDate,
        name: event.name,
        recurrence: event.recurrence,
        startDate: event.startDate,
      );
      convertedValue.fold((l) async* {
        yield CalenderError(
          errMsg: (l as InvalidInputFailure).errMsg,
          errType: CalenderErrorType.submit,
        );
      }, (r) async* {
        var submitOutCome = await submitEvent(Params(r));
        submitOutCome.fold((l) async* {
          yield CalenderError(errMsg: '', errType: CalenderErrorType.submit);
        }, (r) async* {
          yield CalenderEventSubmitSuccess();
        });
      });
    }
  }
}
