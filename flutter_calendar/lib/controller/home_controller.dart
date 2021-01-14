/*~^~^~^~^~^^~^~^~^~^~^~^~^
Developer sivash
 * 10:08 PM
~^~^~^~^~^^~^~^~^~^~^~^~^*/

import 'package:flutter_calendar/util/constanst.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController{

  List events = [];

  void getdata(){
    clientViaUserConsent(Constant.clientID, Constant.scopes, _prompt).then((AuthClient client) {
      var calendartest =CalendarApi(client);
      calendartest.calendarList.list().then((value) {
        events.addAll(value.items);
        update();
      });
    });
    update();
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
 
 





