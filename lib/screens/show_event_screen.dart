import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/models/mEvent.dart';

class ShowEventScreen extends StatelessWidget {
  final EventModel event;

  ShowEventScreen({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                event.description,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateWidget(
                      context,
                      event.startDate,
                      event.repeat != 'Does not repeat',
                    ),
                    _buildDateWidget(
                      context,
                      event.endDate,
                      event.repeat != 'Does not repeat',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateWidget(BuildContext context, String text, bool isRepeat) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(90.0),
      ),
      child: Row(
        children: [
          Icon(
            isRepeat ? Icons.repeat : Icons.alarm_on,
            color: Colors.white54,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
