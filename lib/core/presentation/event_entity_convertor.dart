import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_calender/core/error/failures.dart';

import '../../features/google_calender/domain/entities/event_entity.dart';

const invalidDescription = 'Description shouldn\'t be empty.';
const invalidDueDate = 'Invalid due date.';
const invalidName = 'Name shouldn\'t be empty.';
const invalidStartDate = 'Invalid start date.';

class EventEntityConvertor {
  Either<Failure, EventEntity> parseEvent({
    @required String description,
    @required DateTime dueDate,
    @required String name,
    RepeatMode recurrence,
    DateTime startDate,
  }) {
    if (description == null || description.isEmpty)
      return Left(InvalidInputFailure(invalidDescription));
    if (name == null || name.isEmpty)
      return Left(InvalidInputFailure(invalidName));
    if (dueDate == null || DateTime.now().isAfter(dueDate))
      return Left(InvalidInputFailure(invalidDueDate));
    if (startDate == null || startDate.isBefore(DateTime.now()))
      return Left(InvalidInputFailure(invalidDueDate));
    return Right(EventEntity(
      id: null,
      name: name,
      dueDate: dueDate,
      description: description,
      recurrence: recurrence,
      startDate: startDate,
    ));
  }
}

class InvalidInputFailure extends Failure {
  final String errMsg;
  InvalidInputFailure(this.errMsg);

  @override
  List<Object> get props => [errMsg];
}
