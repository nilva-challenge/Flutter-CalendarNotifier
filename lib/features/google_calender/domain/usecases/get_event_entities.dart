import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event_entity.dart';
import '../repositories/event_entity_repository.dart';

class GetEventEntities extends UseCase<List<EventEntity>, NoParams> {
  final EventEntityRepository eventRepo;
  GetEventEntities(
    this.eventRepo,
  );
  Future<Either<Failure, List<EventEntity>>> call(NoParams params) =>
      eventRepo.getEvents();
}
