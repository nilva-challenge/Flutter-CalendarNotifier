import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/features/google_calender/domain/entities/event_entity.dart';
import 'package:flutter_calender/features/google_calender/presentation/bloc/calender_bloc.dart';

class EventList extends StatelessWidget {
  final List<EventEntity> _cachedList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalenderBloc, CalenderState>(
      builder: (_, state) {
        if (state is CalenderLoaded) {
          _cachedList.clear();
          _cachedList.addAll(state.events);
        }
        if (_cachedList.length == 0) {
          return Center(
            child: Text('Fetching events ...'),
          );
        }
        return ListView.builder(
          itemCount: _cachedList.length,
          itemBuilder: (BuildContext context, int index) =>
              EventItem(event: _cachedList[index]),
        );
      },
    );
  }
}

class EventItem extends StatelessWidget {
  final EventEntity event;
  const EventItem({
    Key key,
    @required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.name),
      subtitle: Text(event.description + '\nRepeat : ${event.recurrence}'),
      isThreeLine: true,
      leading: Text(event.dueDate.toLocal().toString()),
      trailing: Text(event.startDate.toLocal().toString()),
    );
  }
}
