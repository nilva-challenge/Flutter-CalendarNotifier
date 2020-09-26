import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/circular_progress_indicator.dart';
import '../components/event_list_view.dart';
import '../components/floating_action_button.dart';
import '../cubit/eventcubit_cubit.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    final eventCubit = context.bloc<EventcubitCubit>();
    eventCubit.getEventCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Appbar
      appBar: AppBar(
        title: Text('CalendarNotifier'),
        centerTitle: true,
      ),

      //* Body
      body: BlocBuilder<EventcubitCubit, EventcubitState>(
          builder: (context, state) {
        if (state is EventcubitInitial) {
          return MyCircularProgressIndicator();
        } else if (state is EventcubitLoading) {
          return MyCircularProgressIndicator();
        } else if (state is EventcubitLoaded) {
          return MyEventListView();
        } else {
          return Center(child: Text('Error'));
        }
      }),
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}
