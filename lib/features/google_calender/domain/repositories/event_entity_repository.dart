import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event_entity.dart';

abstract class EventEntityRepository {
  Future<Either<Failure, List<EventEntity>>> getEvents();
  Future<Either<Failure, NoValue>> submitEvent(EventEntity event);
}
