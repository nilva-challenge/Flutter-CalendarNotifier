/*~^~^~^~^~^~^~^~^
Developer sivash
1/13/21 // 3:39 PM
~^~^~^~^~^~^~^~^~^*/


import 'package:flutter_calendar/util/constanst.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class AddEventController extends GetxController{


  String startTime = 'Start Time';
  String endTime = 'End Time';
  String title;
  DatePicker dateStart;
  DatePicker dateEnd;

  setTitle(String value){
    title = value;
    update();
  }
   setStartTime() async{
    var datePicked = await DatePicker.showSimpleDatePicker(
      Get.context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
     // titleText: 'Set start event time',
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    startTime = '${datePicked.year}/${datePicked.month}/${datePicked.day}';
    update();
  }
  setEndTime() async{
    var datePicked = await DatePicker.showSimpleDatePicker(
      Get.context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      // titleText: 'Set start event time',
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    endTime = '${datePicked.year}/${datePicked.month}/${datePicked.day}';
    update();
  }


  insert() {
    clientViaUserConsent(Constant.clientID, Constant.scopes, _prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL $value"));

      String calendarId = "primary";
      Event event = Event(); // Create object of event

      event.summary = title;
      DateTime startTime = DateTime.now();
      DateTime endTime = DateTime.now().add(Duration(days: 1));
      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+03:30";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+03:30";
      end.dateTime = endTime;
      event.end = end;
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADD${value.status}");
          if (value.status == "confirmed") {
            print('Event added in google calendar');
          } else {
            print("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        print('Error$e');
      }
    });
  }

  void _prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}