import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_calender/core/error/failures.dart';
import 'package:meta/meta.dart';

import '../../../../core/presentation/event_entity_convertor.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/usecases/get_event_entities.dart';
import '../../domain/usecases/submit_event_entity.dart';

part 'calender_event.dart';
part 'calender_state.dart';

const network_failure_err_msg = 'Network failure. Make sure you are connected.';
const auth_failure_err_msg = 'Google authentication failed.';
const api_failure_err_msg = 'Google calendar failed.';
const unknown_failure_err_msg = 'Unknown error accured.';

String getAppropriateErrorMsg(Failure failure) {
  if (failure is AuthFailure) return auth_failure_err_msg;
  if (failure is NetworkFailure) return network_failure_err_msg;
  if (failure is ApiFailure) return api_failure_err_msg;
  if (failure is InvalidInputFailure) return failure.errMsg;
  return unknown_failure_err_msg;
}

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
      yield loadOutCome.fold((l) {
        return CalenderError(
            errMsg: getAppropriateErrorMsg(l), errType: CalenderErrorType.load);
      }, (r) {
        return CalenderLoaded(r);
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
      yield* convertedValue.fold((l) async* {
        yield CalenderError(
          errMsg: getAppropriateErrorMsg(l),
          errType: CalenderErrorType.submit,
        );
      }, (r) async* {
        yield CalenderEventSubmitInProgress();
        var submitOutCome = await submitEvent(Params(r));
        yield submitOutCome.fold((l) {
          return CalenderError(
              errMsg: getAppropriateErrorMsg(l),
              errType: CalenderErrorType.submit);
        }, (r) {
          return CalenderEventSubmitSuccess();
        });
      });
    }
  }
}
