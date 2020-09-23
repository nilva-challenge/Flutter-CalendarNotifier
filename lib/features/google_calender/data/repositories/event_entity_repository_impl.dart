import 'package:dartz/dartz.dart';
import 'package:flutter_calender/features/google_calender/data/datasources/calender_remote_source.dart';
import 'package:flutter_calender/features/google_calender/data/models/event_entity_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/event_entity_repository.dart';

class EventEntityRepositoryImpl extends EventEntityRepository {
  final CalenderRemoteSource remoteSource;
  EventEntityRepositoryImpl(this.remoteSource);

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    try {
      if (remoteSource == null) return Left(UnknownFailure());
      return Right(await remoteSource.getEvents());
    } catch (err) {
      if (err is AuthException) return Left(AuthFailure());
      if (err is ApiException) return Left(ApiFailure());
      if (err is NetworkException) return Left(NetworkFailure());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, NoValue>> submitEvent(EventEntity event) async {
    try {
      if (remoteSource == null) return Left(UnknownFailure());
      return Right(
        await remoteSource.submitEvent(
          EventEntityModel.fromEventEntity(event),
        ),
      );
    } catch (err) {
      if (err is AuthException) return Left(AuthFailure());
      if (err is ApiException) return Left(ApiFailure());
      if (err is NetworkException) return Left(NetworkFailure());
      return Left(UnknownFailure());
    }
  }
}
