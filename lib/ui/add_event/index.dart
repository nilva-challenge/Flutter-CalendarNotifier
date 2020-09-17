import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttercalendarnotifier/bloc/event_bloc.dart';
import 'package:fluttercalendarnotifier/color.dart';
import 'package:fluttercalendarnotifier/ui/add_event/widget/selection_repeat_item.dart';

class AddEventScreen extends StatefulWidget {
  final EventBloc eventBloc;

  const AddEventScreen({Key key, this.eventBloc}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController(text: '');
  TextEditingController _eventDescription = TextEditingController(text: '');
  int selectedRepeatIndex = 3;
  final repeatElements = [
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
  ];

  List<Widget> _buildSelectionItems() {
    return repeatElements
        .map((val) => SelectionRepeatItem(title: val))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top + 16),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _eventName,
              decoration: InputDecoration(hintText: 'Enter Event name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _eventDescription,
              decoration: InputDecoration(hintText: 'Enter Event description'),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              _buildStartTime(),
              Text('$startTime'),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              _buildEndTime(),
              Text('$endTime'),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 16),
              Text('Repeat',
                  style: TextStyle(color: blue, fontWeight: FontWeight.w500)),
              Expanded(
                child: DirectSelect(
                    itemExtent: 40.0,
                    selectedIndex: selectedRepeatIndex,
                    child: SelectionRepeatItem(
                      isForList: false,
                      title: repeatElements[selectedRepeatIndex],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedRepeatIndex = index;
                      });
                    },
                    items: _buildSelectionItems()),
              ),
            ],
          ),
          SizedBox(height: 16),
          RaisedButton(
              child: Text(
                'Insert Event',
              ),
              color: Colors.grey,
              onPressed: () {
                widget.eventBloc.addEvent(
                  _eventName.text,
                  _eventDescription.text,
                  startTime,
                  endTime,
                  repeatElements[selectedRepeatIndex],
                );
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  Widget _buildStartTime() {
    return FlatButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2019, 3, 5),
          maxTime: DateTime(2200, 6, 7),
          onChanged: (date) {
            print('change $date');
          },
          onConfirm: (date) {
            setState(() {
              this.startTime = date;
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      child: Text(
        'Event Start Time',
        style: TextStyle(color: blue),
      ),
    );
  }

  Widget _buildEndTime() {
    return FlatButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2019, 3, 5),
          maxTime: DateTime(2200, 6, 7),
          onChanged: (date) {
            print('change $date');
          },
          onConfirm: (date) {
            setState(() {
              this.endTime = date;
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      child: Text(
        'Event End Time',
        style: TextStyle(color: blue),
      ),
    );
  }
}
