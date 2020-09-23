import 'package:flutter_calender/features/google_calender/data/models/event_entity_model.dart';
import 'package:flutter_calender/features/google_calender/domain/entities/event_entity.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final String id = '241524544lkjjhkhj';
  final int daysAhead = 2;
  final int recurrenceIndex = 2;
  final EventEntityModel event = EventEntityModel(
    id: id,
    name: 'test name',
    description: 'test describtion',
    startDate: DateTime.now(),
    dueDate: DateTime.now().add(Duration(days: daysAhead)),
    recurrenceRaw: repeatRawToEnum.keys.toList()[recurrenceIndex],
  );

  test('should be sub class of event entity with valid repeatmode', () {
    expect(event, isA<EventEntity>());
    expect(event.recurrence, RepeatMode.values[recurrenceIndex]);
  });
}
