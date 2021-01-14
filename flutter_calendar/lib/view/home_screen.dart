/*~^~^~^~^~^~^~^~^
Developer siavash
1/13/21 // 4:57 PM
~^~^~^~^~^~^~^~^~^*/


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'add_event_screen.dart';
import 'package:flutter_calendar/controller/home_controller.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {

HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Google Calendar'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            navigator.push(MaterialPageRoute(builder: (context) => AddEventScreen(),));
          },),
        body: SafeArea(
          child: Container(
            child: GetBuilder(
              init: _controller,
              builder: (controller) {
                return _controller.events.length != 0 ? ListView.builder(
                  itemCount: _controller.events.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 80,
                        child: Card(
                          shadowColor:Colors.black12 ,
                          elevation: 2,
                          child: Center(
                            child: Text(_controller.events[index].description ?? ''),
                          ),
                        ),
                      ),
                    );
                  },):Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not Found Any Event'),
                      SizedBox(height: 20,),
                      RaisedButton(
                        child: Text('refresh',style: TextStyle(
                          color: Colors.white
                        ),),
                        color: Colors.blueAccent,
                        onPressed: () => _controller.getdata(),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }


}