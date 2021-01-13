/*~^~^~^~^~^~^~^~^
Developer siavash
1/13/21 // 4:57 PM
~^~^~^~^~^~^~^~^~^*/


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth.dart';

import 'add_event_screen.dart';

class HomeScreen extends StatelessWidget {

  static const _scopes = const [calendar.CalendarApi.CalendarScope];
  @override
  Widget build(BuildContext context) {
    var _credentials;
    if (Platform.isAndroid) {
      _credentials =  ClientId(
          "919163830062-ouhqk3pls9ljcih3oh9279b6klelmc7m.apps.googleusercontent.com", "");
    } else if (Platform.isIOS) {
      _credentials = ClientId(
          "YOUR_CLIENT_ID_FOR_IOS_APP_RETRIEVED_FROM_Google_Console_Project_EARLIER",'');
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Google Calendar'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            //_addEventController.setStartTime();
            navigator.push(MaterialPageRoute(builder: (context) => AddEventScreen(),));
            // var datePicked = await DatePicker.showSimpleDatePicker(
            //    context,
            //    initialDate: DateTime.now(),
            //    firstDate: DateTime.now(),
            //    lastDate: DateTime(2100),
            //    dateFormat: "dd-MMMM-yyyy",
            //    locale: DateTimePickerLocale.en_us,
            //    looping: true,
            //  );
          },),
        body: SafeArea(
          child: Container(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 80,
                    child: Card(
                      shadowColor:Colors.black12 ,
                      elevation: 2,
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    ),
                  ),
                );
              },),
          ),
        ));
  }
}