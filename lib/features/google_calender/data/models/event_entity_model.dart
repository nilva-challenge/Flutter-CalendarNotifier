import 'package:meta/meta.dart';

import '../../domain/entities/event_entity.dart';

const Map<String, RepeatMode> repeatRawToEnum = {
  null: RepeatMode.none,
  'RRULE:FREQ=DAILY': RepeatMode.daily,
  'RRULE:FREQ=WEEKLY': RepeatMode.weekly,
  'RRULE:FREQ=MONTHLY': RepeatMode.monthly,
  'RRULE:FREQ=YEARLY': RepeatMode.yearly,
};

const Map<RepeatMode, String> repeatEnumToRaw = {
  RepeatMode.none: null,
  RepeatMode.daily: 'RRULE:FREQ=DAILY',
  RepeatMode.weekly: 'RRULE:FREQ=WEEKLY',
  RepeatMode.monthly: 'RRULE:FREQ=MONTHLY',
  RepeatMode.yearly: 'RRULE:FREQ=YEARLY'
};

class EventEntityModel extends EventEntity {
  final String recurrenceRaw;

  EventEntityModel({
    @required id,
    @required name,
    @required description,
    @required dueDate,
    this.recurrenceRaw,
    startDate,
  }) : super(
          id: id,
          name: name,
          description: description,
          dueDate: dueDate,
          recurrence: repeatRawToEnum[recurrenceRaw],
          startDate: startDate,
        );

  EventEntityModel.fromEventEntity(EventEntity eventEntity)
      : recurrenceRaw = repeatEnumToRaw[eventEntity.recurrence],
        super(
          id: eventEntity.id,
          name: eventEntity.name,
          description: eventEntity.description,
          dueDate: eventEntity.dueDate,
          recurrence: eventEntity.recurrence,
          startDate: eventEntity.startDate,
        );
}
