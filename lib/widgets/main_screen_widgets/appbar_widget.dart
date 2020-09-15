import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_app/cubit/calendar_cubit.dart';

class AppbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 30.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.menu,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                onChanged: (value) =>
                    context.bloc<CalendarCubit>().searchEvent(value),
                cursorColor: Colors.grey,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search calendar title...',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onPressed: () => context.bloc<CalendarCubit>().removeEvents(),
            )
          ],
        ),
      ),
    );
  }
}
