import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/event_entity_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event_entity.dart';

class SubmitEventEntity extends UseCase<NoValue, Params> {
  final EventEntityRepository eventRepo;
  SubmitEventEntity(
    this.eventRepo,
  );
  Future<Either<Failure, NoValue>> call(Params params) =>
      eventRepo.submitEvent(params.event);
}

class Params extends Equatable {
  final EventEntity event;
  Params(
    this.event,
  );
  @override
  List<Object> get props => event.props;
}
