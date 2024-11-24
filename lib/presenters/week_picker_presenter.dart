import 'package:flutter/material.dart';
import 'week_picker_model.dart';

class WeekPresenter {
  late WeekModel _weekModel;
  late Function(DateTime) onDateSelected;
  late Function(List<DateTime>) onWeekUpdated;

  WeekPresenter({required this.onDateSelected, required this.onWeekUpdated}) {
    _weekModel = WeekModel();
  }

  // Method to handle date selection
  void selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year, today.month, today.day - 365),
      lastDate: DateTime(today.year, today.month, today.day + 365),
    );

    if (pickedDate != null) {
      onDateSelected(pickedDate);
      List<DateTime> weekDays = _weekModel.getWeekDays(pickedDate);
      onWeekUpdated(weekDays);
    }
  }
}
