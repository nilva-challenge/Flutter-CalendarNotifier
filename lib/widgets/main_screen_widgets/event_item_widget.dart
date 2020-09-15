import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/cubit/calendar_cubit.dart';
import 'package:flutter_calendar_app/models/mEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_app/screens/show_event_screen.dart';

class EventItemWidget extends StatelessWidget {
  final EventModel event;

  EventItemWidget({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(event.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.bloc<CalendarCubit>().removeEvent(event.id);
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowEventScreen(
              event: event,
            ),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.white30,
                width: 0.5,
              ),
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  event.description,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                _buildDateWidget(
                  context,
                  event.startDate,
                  event.repeat != 'Does not repeat',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                _buildDateWidget(
                  context,
                  event.endDate,
                  event.repeat != 'Does not repeat',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateWidget(BuildContext context, String text, bool isRepeat) {
    return Row(
      children: [
        Icon(
          isRepeat ? Icons.repeat : Icons.alarm_on,
          color: Colors.white54,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
