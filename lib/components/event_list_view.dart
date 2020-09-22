import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) => ListTile(
        leading: _eventListleading(),
        title: Text('Event name'),
        subtitle: Text('Event description...'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }

  _eventListleading() {
    return Icon(Icons.calendar_today);
  }
}
