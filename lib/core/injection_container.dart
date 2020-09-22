import 'package:flutter_calender/features/google_calender/data/repositories/event_entity_repository_impl.dart';
import 'package:flutter_calender/features/google_calender/domain/repositories/event_entity_repository.dart';
import 'package:flutter_calender/features/google_calender/domain/usecases/get_event_entities.dart';
import 'package:flutter_calender/features/google_calender/domain/usecases/submit_event_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../features/google_calender/data/datasources/calender_remote_source.dart';
import '../features/google_calender/presentation/bloc/calender_bloc.dart';
import 'presentation/event_entity_convertor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! Features - Auth Data
  sl.registerFactory(() =>
      CalenderBloc(eventConvertor: sl(), getEvents: sl(), submitEvent: sl()));

  sl.registerLazySingleton(() => CalenderRemoteSource(sl()));
  sl.registerLazySingleton<EventEntityRepository>(
      () => EventEntityRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetEventEntities(sl()));
  sl.registerLazySingleton(() => SubmitEventEntity(sl()));
  // ! Core
  sl.registerLazySingleton(() => EventEntityConvertor());
  // ! External
  sl.registerLazySingleton(() => ClientId(
      '736849729520-pkbq8keoui439l226buo9s7u0vrjjg1q.apps.googleusercontent.com',
      ''));
}
