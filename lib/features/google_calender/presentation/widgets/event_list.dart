import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/features/google_calender/domain/entities/event_entity.dart';
import 'package:flutter_calender/features/google_calender/presentation/bloc/calender_bloc.dart';
import 'package:intl/intl.dart' as intl;

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
            child: Text(state is CalenderLoading
                ? 'Fetching events ...'
                : 'No Calendar Event.'),
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
    final dateWidth = MediaQuery.of(context).size.width * 0.2;
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(event.name),
        subtitle: Text(event.description +
            '\nRepeat : ${event.recurrence.toString().replaceAll("RepeatMode.", "")}'),
        isThreeLine: true,
        leading: Container(
          width: dateWidth,
          child: Text(
            'Due to : ' + intl.DateFormat().add_MEd().format(event.dueDate),
            maxLines: 3,
          ),
        ),
        trailing: Container(
          width: dateWidth,
          child: Text(
            'Started : ' + intl.DateFormat().add_MEd().format(event.dueDate),
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}
