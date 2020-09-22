import 'package:meta/meta.dart';

import '../../domain/entities/event_entity.dart';

const Map<String, RepeatMode> repeatRawToEnum = {
  null: RepeatMode.none,
  'RRULE:FREQ=DAILY': RepeatMode.daily,
  'RRULE:FREQ=WEEKLY': RepeatMode.weekly,
  'RRULE:FREQ=MONTHLY': RepeatMode.monthly,
  'RRULE:FREQ=YEARLY': RepeatMode.yearly,
};

class EventEntityModel extends EventEntity {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime dueDate;
  final String recurrenceRaw;

  EventEntityModel({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.dueDate,
    this.recurrenceRaw,
    this.startDate,
  }) : super(
          id: id,
          name: name,
          description: description,
          dueDate: dueDate,
          recurrence: repeatRawToEnum[recurrenceRaw],
          startDate: startDate,
        );
}
