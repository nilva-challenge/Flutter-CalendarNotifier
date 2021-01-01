import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'Cal_Event.dart';
import 'CalendarClient.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calendar Notifier',
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  String repeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar app"),
      ),
      body: Center(
          child: SizedBox(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getEventName(),
          getEventDescription(),
          getStartTime(),
          getEndTime(),
          getRepeat(),
          FloatingActionButton(
            child: Text("Add"),
            onPressed: (){
            Cal_Event event = Cal_Event(nameController.text, descriptionController.text, startTime, endTime, repeat);
           CalendarClient().insert(event);
          },)
        ],
      ))),
    );
  }

  Widget createARatio(String text, String frequency) {
    return
       Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 0.1,
        children: [
           Radio(
            value: frequency,
            groupValue: repeat,
            onChanged: (value) {
              setState(() {
                repeat = value;
              });
            },
          ),Text(
            text,
          ),],);



  }

  Widget getEventName() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: 'Enter event name'),
        ));
  }

  getRepeat() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("repeat: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          createARatio("None", null),
          createARatio("Daily", 'RRULE:FREQ=DAILY'),
          createARatio("Weekly", 'RRULE:FREQ=WEEKLY'),
          createARatio("Monthly", 'RRULE:FREQ=MONTHLY'),
          createARatio("Yearly", 'RRULE:FREQ=YEARLY'),
        ],
      ),
    );
  }

  getEventDescription() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: descriptionController,
          decoration: InputDecoration(hintText: 'Enter event description'),
        ));
  }

  getStartTime() {
    return  Row(
      children: <Widget>[
        FlatButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2020, 1, 1),
                  maxTime: DateTime(2100, 1, 1),
                  onConfirm: (date) {
                    setState(() {
                      this.startTime = date;
                    });
                  }, currentTime: DateTime.now());
            },
            child: Text(
              'Event Start Time',
              style: TextStyle(color: Colors.blue),
            )),
        Text('$startTime'),
      ],
    );
  }

  getEndTime() {
    return Row(
      children: <Widget>[
        FlatButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2020, 1, 1),
                  maxTime: DateTime(2100, 1, 1)
                  , onConfirm: (date) {
                    setState(() {
                      this.endTime = date;
                    });
                  }, currentTime: DateTime.now());
            },
            child: Text(
              'Event End Time',
              style: TextStyle(color: Colors.blue),
            )),
        Text('$endTime'),
      ],
    );
  }
}
