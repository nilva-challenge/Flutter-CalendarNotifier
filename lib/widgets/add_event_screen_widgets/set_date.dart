import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/utilities.dart';

class SetDate extends StatefulWidget {
  @override
  _SetDateState createState() => _SetDateState();
}

class _SetDateState extends State<SetDate> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String _startDate;
  String _endDate;
  String _repeat = 'Does not repeat';

  @override
  void initState() {
    super.initState();

    _startDate = Utilities.formatDateTimeDisplay(DateTime.now().toString());
    _endDate = Utilities.formatDateTimeDisplay(DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Set date',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.pop(
              context,
              {'StartDate': _startDate, 'EndDate': _endDate, 'Repeat': _repeat},
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            _buildListTile(
                'Start DateTime', _startDate, (value) => _startDate = value),
            _buildListTile(
                'End DateTime', _endDate, (value) => _endDate = value),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    useRootNavigator: true,
                    builder: (context) {
                      return Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.42,
                        child: ListView(
                          children: [
                            _buildRepeatListTile(
                              'Does not repeat',
                              () => _repeatItemClick('Does not repeat'),
                            ),
                            _buildRepeatListTile(
                              'Daily',
                              () => _repeatItemClick('Daily'),
                            ),
                            _buildRepeatListTile(
                              'Weekly',
                              () => _repeatItemClick('Weekly'),
                            ),
                            _buildRepeatListTile(
                              'Monthly',
                              () => _repeatItemClick('Monthly'),
                            ),
                            _buildRepeatListTile(
                              'Yearly',
                              () => _repeatItemClick('Yearly'),
                            ),
                          ],
                        ),
                      );
                    });
              },
              title: const Text(
                'Repeat',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                _repeat,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _repeatItemClick(String value) {
    Navigator.pop(context);
    setState(() {
      _repeat = value;
    });
  }

  Widget _buildRepeatListTile(String title, Function press) {
    return ListTile(
      onTap: press,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildListTile(String title, String subTitle, Function onChange) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: DateTimePicker(
        type: DateTimePickerType.dateTime,
        initialValue: subTitle,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        use24HourFormat: true,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(0.0),
        ),
        style: TextStyle(
          color: Colors.white.withOpacity(0.6),
        ),
        onChanged: onChange,
      ),
    );
  }
}
