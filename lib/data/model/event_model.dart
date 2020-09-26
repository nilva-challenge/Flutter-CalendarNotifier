import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class EventModel extends Equatable {
  final String eventName;
  final String eventDesciption;
  final DateTime dueDate;

  EventModel({
    @required this.eventName,
    @required this.eventDesciption,
    @required this.dueDate,
  });

  @override
  List<Object> get props => [
        eventName,
        eventDesciption,
        dueDate,
      ];
}
