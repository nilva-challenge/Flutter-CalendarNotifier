import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/features/google_calender/presentation/bloc/calender_bloc.dart';
import 'package:flutter_calender/features/google_calender/presentation/widgets/event_list.dart';
import 'package:flutter_calender/features/google_calender/presentation/widgets/submit_event_bottom_sheet.dart';

import '../widgets/refresh_events_button.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CalenderBloc>(context).add(GetCalenderEvents());
    return Scaffold(
      appBar: AppBar(
        title: Text('Calender App'),
        actions: [
          RefreshEventsButton(),
        ],
      ),
      body: EventList(),
      floatingActionButton: Builder(
        builder: (ctx) => FloatingActionButton(
          child: Icon(Icons.playlist_add),
          onPressed: () => showBottomSheet(
              context: ctx, builder: (_) => SubmitEventBottomSheet()),
        ),
      ),
    );
  }
}
