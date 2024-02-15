import 'package:flutter/material.dart';
import 'package:hunt_and_rent/widgets/helper.dart';
import 'package:intl/intl.dart';
import '../resources/resources.dart';

class DateTimePickerServices {
  static DateTime selectedDate = DateTime.now();
  static DateTime selectedSchoolFromDate = DateTime.now();
  static DateTime selectedIssueDate = DateTime.now();
  static DateTime selectSessionStartDate = DateTime.now();
  static TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  static Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    DateTime now = DateTime.now();
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Helper.createMaterialColor(R.colors.theme))),
            child: child!);
      },
    );
    if (picked != null) selectedTime = picked;
    controller.text = DateFormat(
            "       hh              :           mm           :           a     ")
        .format(DateTime(now.year, now.month, now.day, selectedTime.hour,
            selectedTime.minute));
  }

  // selected date of birth function
  static Future<void> selectDateFunction(
    DateTime initialDate,
    DateTime firstDate,
    DateTime lastDate,
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Helper.createMaterialColor(R.colors.theme))),
            child: child!);
      },
      context: context,
      initialDate: initialDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) selectedDate = picked;
    controller.text = DateFormat(
            "     MMM            |           dd           |           yyyy     ")
        .format(selectedDate);
  }
}
