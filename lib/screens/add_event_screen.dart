import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/models/mEvent.dart';
import 'package:flutter_calendar_app/widgets/add_event_screen_widgets/body_widget.dart';
import 'package:flutter_calendar_app/widgets/add_event_screen_widgets/set_date.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  bool _hasSetTime = false;
  String _startDate = '';
  String _endDate = '';
  String _repeat = '';
  String _title = 'Untitled';
  String _description = 'No description';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BodyWidget(
        descriptionChange: (value) => _description = value,
        titleChange: (value) => _title = value,
        hasSetTime: _hasSetTime,
        startDate: _startDate,
        endDate: _endDate,
        repeat: _repeat,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
        ),
        onPressed: _saveButtonClick,
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.alarm,
            color: Colors.grey,
          ),
          onPressed: _setDateButtonClick,
        ),
      ],
    );
  }

  void _setDateButtonClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetDate(),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          _hasSetTime = true;
          _startDate = value['StartDate'];
          _endDate = value['EndDate'];
          _repeat = value['Repeat'];
        });
      }
    });
  }

  void _saveButtonClick() {
    if (_startDate == '' || _endDate == '') return Navigator.pop(context);

    EventModel _event = EventModel(
      id: '',
      title: _title,
      description: _description,
      endDate: _endDate,
      startDate: _startDate,
      repeat: _repeat,
    );
    Navigator.pop(context, _event);
  }
}
