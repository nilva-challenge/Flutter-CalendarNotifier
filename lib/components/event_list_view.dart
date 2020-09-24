import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyEventListView extends StatelessWidget {
  final String eventName;
  final String eventDescription;

  const MyEventListView({
    Key key,
    @required this.eventName,
    @required this.eventDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) => ListTile(
        leading: _eventListleading(),
        title: Text(eventName),
        subtitle: Text(eventDescription),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }

  _eventListleading() {
    return Icon(Icons.calendar_today);
  }
}
