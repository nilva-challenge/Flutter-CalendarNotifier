import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class FakeEventsModel extends Equatable {
  final String eventName;
  final String eventDesciption;
  final DateTime eventCreated;

  FakeEventsModel({
    @required this.eventName,
    @required this.eventDesciption,
    @required this.eventCreated,
  });

  @override
  List<Object> get props => [
        eventName,
        eventDesciption,
        eventCreated,
      ];
}
