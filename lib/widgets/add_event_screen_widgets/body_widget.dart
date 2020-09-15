import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  final Function titleChange;
  final Function descriptionChange;
  final bool hasSetTime;
  final String startDate;
  final String endDate;
  final String repeat;

  BodyWidget({
    @required this.descriptionChange,
    this.titleChange,
    this.hasSetTime,
    @required this.startDate,
    @required this.endDate,
    @required this.repeat,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Title', true, titleChange),
            _buildTextField('Description', false, descriptionChange),
            Visibility(
              visible: hasSetTime,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateWidget(
                      context,
                      startDate.toString(),
                      repeat != 'Does not repeat',
                    ),
                    _buildDateWidget(
                      context,
                      endDate.toString(),
                      repeat != 'Does not repeat',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, bool isTitle, Function onChange) {
    return TextField(
      onChanged: onChange,
      cursorColor: Colors.grey,
      maxLines: 30,
      minLines: 1,
      style: TextStyle(
        color: Colors.white,
        fontSize: isTitle ? 20.0 : 16.0,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.5),
          fontSize: isTitle ? 20 : 16,
        ),
        hintText: hint,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  Widget _buildDateWidget(BuildContext context, String text, bool isRepeat) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(90.0),
      ),
      child: Row(
        children: [
          Icon(
            isRepeat ? Icons.repeat : Icons.alarm_on,
            color: Colors.white54,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
