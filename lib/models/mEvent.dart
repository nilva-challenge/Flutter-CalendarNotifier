import 'package:flutter/cupertino.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String repeat;

  EventModel({
    @required this.id,
    this.title,
    this.description,
    this.endDate,
    this.startDate,
    this.repeat,
  });
}
