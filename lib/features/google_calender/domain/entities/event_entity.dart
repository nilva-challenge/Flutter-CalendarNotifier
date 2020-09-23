import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum RepeatMode {
  none,
  daily,
  weekly,
  monthly,
  yearly,
}

class EventEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime dueDate;
  final RepeatMode recurrence;

  EventEntity({
    @required this.id,
    @required this.name,
    @required this.dueDate,
    @required this.description,
    this.startDate,
    this.recurrence = RepeatMode.none,
  });

  @override
  List<Object> get props => [id];
}
