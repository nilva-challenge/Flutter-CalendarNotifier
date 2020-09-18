import 'package:calendar_challenge/bloc.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  final EventBloc eventBloc;

  const AddEventScreen({Key key, this.eventBloc}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController _eventTitle = TextEditingController(text: '');
  TextEditingController _eventDescription = TextEditingController(text: '');
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  String _radioValue;
  String choice;

  Future<void> _selectDate(BuildContext context, DateTime date) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != date)
      setState(() {
        date = picked;
      });
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'Daily':
          choice = value;
          break;
        case 'Weekly':
          choice = value;
          break;
        case 'Monthly':
          choice = value;
          break;
        case 'Yearly':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice);
    });
  }

  @override
  void initState() {
    _radioValue = 'Daily';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      color: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8))),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top + 16),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: _eventTitle,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: _eventDescription,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _selectDate(context, startTime),
                    child: Text('Start Date'),
                  ),
                  Text('$startTime'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _selectDate(context, startTime),
                    child: Text('End Date'),
                  ),
                  Text('$endTime'),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Repeat',
              ),
              Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    'Daily',
                  ),
                  Radio(
                    value: 'Daily',
                    groupValue: _radioValue,
                    onChanged: radioButtonChanges,
                  ),
                  Text(
                    'Weekly',
                  ),
                  Radio(
                    value: 'Weekly',
                    groupValue: _radioValue,
                    onChanged: radioButtonChanges,
                  ),
                  Text(
                    'Monthly',
                  ),
                  Radio(
                    value: 'Monthly',
                    groupValue: _radioValue,
                    onChanged: radioButtonChanges,
                  ),
                  Text(
                    'Yearly',
                  ),
                  Radio(
                    value: 'Yearly',
                    groupValue: _radioValue,
                    onChanged: radioButtonChanges,
                  ),
                ],
              ),
              SizedBox(height: 16),
              RaisedButton(
                  child: Text(
                    'Add Event',
                  ),
                  onPressed: () {
                    widget.eventBloc.addEvent(
                      _eventTitle.text,
                      _eventDescription.text,
                      startTime,
                      endTime,
                      _radioValue,
                    );
                    Navigator.pop(context);
                  }),
            ],
          )),
    );
  }
}
