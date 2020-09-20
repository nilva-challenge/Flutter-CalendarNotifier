import 'package:flutter/material.dart';
import 'package:flutter_calendar_notifier/models/event_data.dart';
import 'package:flutter_calendar_notifier/utils/app_bar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_calendar_notifier/models/event.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({Key key}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String _eventName;
  String _eventDescription;
  String _startTimeString = 'pick a start time';
  String _endTimeString = 'pick a end time';
  DateTime _startTime;
  DateTime _endTime;
  String _repeat;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(MediaQuery.of(context).size.width, 60, 'Add new event'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                    decoration: InputDecoration(
                      helperText: 'like: Meeting with Bob',
                      hintText: 'Event name',
                    ),
                    onChanged: (name) {
                      setState(() {
                        this._eventName = name;
                      });
                    }),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    helperText: 'like: Talking about home works and finals.',
                    hintText: 'Event Description',
                  ),
                  onChanged: (des) {
                    setState(() {
                      this._eventDescription = des;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Start date: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'End date: ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: OutlineButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$_startTimeString',
                            ),
                          ),
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2024),
                                onChanged: (date) {}, onConfirm: (date) {
                              this._startTime = date;
                              setState(() {
                                this._startTimeString = date.toString();
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: OutlineButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$_endTimeString',
                            ),
                          ),
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2024),
                                onChanged: (date) {}, onConfirm: (date) {
                              setState(() {
                                this._endTimeString = date.toString();
                              });
                              this._endTime = date;
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Repeat: ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: null,
                      groupValue: _repeat,
                      onChanged: (value) {
                        setState(() {
                          _repeat = value;
                        });
                      },
                    ),
                    Text('None'),
                    Radio(
                      value: 'RRULE:FREQ=DAILY',
                      groupValue: _repeat,
                      onChanged: (value) {
                        setState(() {
                          _repeat = value;
                        });
                      },
                    ),
                    Text('Daily'),
                    Radio(
                      value: 'RRULE:FREQ=WEEKLY',
                      groupValue: _repeat,
                      onChanged: (value) {
                        setState(() {
                          _repeat = value;
                        });
                      },
                    ),
                    Text('Weekly'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'RRULE:FREQ=MONTHLY',
                      groupValue: _repeat,
                      onChanged: (value) {
                        setState(() {
                          _repeat = value;
                        });
                      },
                    ),
                    Text('Monthly'),
                    Radio(
                      value: 'RRULE:FREQ=YEARLY',
                      groupValue: _repeat,
                      onChanged: (value) {
                        setState(() {
                          _repeat = value;
                        });
                      },
                    ),
                    Text('Yearly'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                    //side: BorderSide(color: Colors.red),
                  ),
                  color: Colors.green[800],
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    child: Center(
                      child: Text(
                        'Add Event',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (this._startTime != null && this._endTime != null) {
                      Event newEvent = new Event(
                          this._eventName,
                          this._eventDescription,
                          this._startTime,
                          this._endTime,
                          this._repeat);
                      Provider.of<EventData>(context, listen: false)
                          .addNewEvent(newEvent);
                      Provider.of<EventData>(context, listen: false).loading =
                          true;
                    }
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
