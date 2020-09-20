import 'package:flutter/material.dart';
import 'package:flutter_calendar_notifier/models/event_data.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double width;
  final double height;
  final String title;

  MyAppBar(this.width, this.height, this.title);
  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.08,
      ),
      child: AppBar(
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.refresh),
        //     color: Colors.white,
        //     onPressed: () {
        //       Provider.of<EventData>(context, listen: false).getEvents();
        //     },
        //   )
        // ],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.amber[800],
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(this.width, this.height);
}
