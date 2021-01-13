/*~^~^~^~^~^~^~^~^
Developer sivash
1/13/21 // 3:39 PM
~^~^~^~^~^~^~^~^~^*/


import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';

class AddEventController extends GetxController{

  String startTime = 'Start Time';
  String endTime = 'End Time';
  String title;

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


}