/*~^~^~^~^~^~^~^~^
Developer siavash
1/13/21 // 3:22 PM
~^~^~^~^~^~^~^~^~^*/

import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/add_event_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddEventScreen extends StatelessWidget {
  AddEventController _addEventController = Get.put(AddEventController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text( 'Add event calendar'),),
      body: Container(
        height: Get.height,
        child:Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _addEventController.setTitle(value);
                },
                decoration: InputDecoration(
                  hintText: 'enter title event',
                ),
              ),
              SizedBox(
              height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.greenAccent,
                          onPressed: (){
                            _addEventController.setStartTime();
                          },
                        child: GetBuilder(
                            init: _addEventController,
                            builder:(_) {
                              return Text(_addEventController.startTime,style: TextStyle(color: Colors.white));
                            }, ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.redAccent,
                          onPressed: () {
                          _addEventController.setEndTime();
                          },
                        child: GetBuilder(
                          init: _addEventController,
                          builder:(_) {
                            return Text(_addEventController.endTime,style: TextStyle(color: Colors.white));
                          }, )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              RaisedButton(onPressed: (){

              },
                child: Text('insert'),
              )
            ],
          ),
        ) ,
      ),
    );
  }
}

