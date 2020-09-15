import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/cubit/calendar_cubit.dart';
import 'package:flutter_calendar_app/models/mEvent.dart';
import 'package:flutter_calendar_app/utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_app/widgets/main_screen_widgets/event_item_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarCubit, CalendarState>(
      listener: (context, state) {
        if (state is AddCalendarState) {
          /** Event add successfully **/
          context.bloc<CalendarCubit>().getEvent();
        } else if (state is CalendarError) {
          /** Event doesn't add successfully **/
          Utilities.showError(context, state.message);
          context.bloc<CalendarCubit>().getEvent();
        }
      },
      builder: (context, state) {
        if (state is CalendarInitialState) {
          return Container();
        } else if (state is CalendarLoadingState) {
          return _buildStateLoading(context);
        } else if (state is GetCalendarState) {
          return state.events.length > 0
              ? _buildEventItem(state.events, context)
              : _buildEmptyItem();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildStateLoading(context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.width * 0.08,
        child: ModalProgressHUD(
          inAsyncCall: true,
          color: Colors.transparent,
          progressIndicator: LoadingIndicator(
            indicatorType: Indicator.ballRotateChase,
            color: Colors.white,
          ),
          child: Container(),
        ),
      ),
    );
  }

  Widget _buildEventItem(List<EventModel> _events, context) {
    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        return EventItemWidget(
          event: _events[index],
        );
      },
    );
  }

  Widget _buildEmptyItem() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nothing to show!',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Push + button to add event!',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
