import 'package:dartz/dartz.dart';
import 'package:flutter_calender/core/usecases/usecase.dart';
import 'package:flutter_calender/features/google_calender/domain/entities/event_entity.dart';
import 'package:flutter_calender/features/google_calender/domain/repositories/event_entity_repository.dart';
import 'package:flutter_calender/features/google_calender/domain/usecases/submit_event_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockEventEntityRepository extends Mock implements EventEntityRepository {}

main() {
  MockEventEntityRepository mockRepo;
  SubmitEventEntity submitEvents;
  final String id = '241524544lkjjhkhj';
  final int daysAhead = 2;

  final EventEntity event = EventEntity(
    id: id,
    name: 'test name',
    description: 'test describtion',
    startDate: DateTime.now(),
    dueDate: DateTime.now().add(Duration(days: daysAhead)),
  );

  final noVal = NoValue();

  setUp(() {
    mockRepo = MockEventEntityRepository();
    submitEvents = SubmitEventEntity(mockRepo);
  });

  test(
    'should submit event to repository',
    () async {
      when(mockRepo.submitEvent(event))
          .thenAnswer((realInvocation) async => Right(noVal));
      final result = await submitEvents(Params(event));

      expect(result, Right(noVal));
      verify(mockRepo.submitEvent(event));
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
