import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/features/google_calender/presentation/bloc/calender_bloc.dart';

class RefreshEventsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalenderBloc, CalenderState>(
      builder: (_, state) => (state is CalenderLoading)
          ? Container(
              padding: EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(),
              ),
            )
          : IconButton(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => BlocProvider.of<CalenderBloc>(context)
                  .add(GetCalenderEvents()),
            ),
      listener: (_, state) {
        if (state is CalenderError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMsg),
            ),
          );
        }
      },
    );
  }
}
