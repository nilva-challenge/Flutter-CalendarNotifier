import 'package:dartz/dartz.dart';
import 'package:flutter_calender/core/usecases/usecase.dart';
import 'package:flutter_calender/features/google_calender/domain/entities/event_entity.dart';
import 'package:flutter_calender/features/google_calender/domain/repositories/event_entity_repository.dart';
import 'package:flutter_calender/features/google_calender/domain/usecases/get_event_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockEventEntityRepository extends Mock implements EventEntityRepository {}

main() {
  MockEventEntityRepository mockRepo;
  GetEventEntities getEvents;
  final String id = '241524544lkjjhkhj';
  final int daysAhead = 2;

  final EventEntity event = EventEntity(
    id: id,
    name: 'test name',
    description: 'test describtion',
    startDate: DateTime.now(),
    dueDate: DateTime.now().add(Duration(days: daysAhead)),
  );

  final eventList = [event];

  setUp(() {
    mockRepo = MockEventEntityRepository();
    getEvents = GetEventEntities(mockRepo);
  });

  test(
    'should get event from repository',
    () async {
      when(mockRepo.getEvents())
          .thenAnswer((realInvocation) async => Right(eventList));
      final result = await getEvents(NoParams());

      expect(result, Right(eventList));
      verify(mockRepo.getEvents());
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
