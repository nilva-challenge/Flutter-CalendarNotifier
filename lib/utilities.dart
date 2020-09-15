import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class Utilities {
  static void showError(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Icon(
              Icons.error,
              color: Colors.red,
              size: 35,
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    '$content',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 2,
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  static void showSuccess(BuildContext context, String content, Function then) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 35,
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  '$content',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 2,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then(then);
  }

  static String formatDateTimeDisplay(String date) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm');
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = displayFormatter.format(displayDate);
    return formatted;
  }

  static String createDateField(String value) {
    String _dt = Utilities.formatDateTimeDisplay(value);
    _dt = _dt.replaceAll('-', '');
    _dt = _dt.replaceAll(':', '');
    _dt = _dt.replaceAll(' ', 'T');
    return _dt + '00Z';
  }
}
