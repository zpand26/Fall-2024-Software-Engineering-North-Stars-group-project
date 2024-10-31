import 'package:flutter/material.dart';
import 'package:day_picker/day_picker.dart';
import '../presenter.dart';

class dayEntryPage extends StatefulWidget {
  final AppPresenter presenter;

  dayEntryPage(this.presenter);

  @override
  _dayEntryPageState createState() => _dayEntryPageState();
}

final List<DayInWeek> _days = [
  DayInWeek("Mon", dayKey: "monday"),
  DayInWeek("Tue", dayKey: "tuesday"),
  DayInWeek("Wed", dayKey: "wednesday"),
  DayInWeek("Thu", dayKey: "thursday"),
  DayInWeek("Fri", dayKey: "friday"),
  DayInWeek("Sat", dayKey: "saturday", isSelected: true),
  DayInWeek("Sun", dayKey: "sunday", isSelected: true),
];

List<String> listOfDays = [];

class _dayEntryPageState extends State<dayEntryPage> {
  final TextEditingController _dayEntryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final customWidgetKey = new GlobalKey<SelectWeekDaysState>();

    SelectWeekDays selectWeekDays = SelectWeekDays(
      key: customWidgetKey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      days: _days,
      border: false,
      width: MediaQuery
          .of(context)
          .size
          .width / 1.4,
      boxDecoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30.0),
      ),
      onSelect: (values) {
        print(values);
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Calories'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _dayEntryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Calories and Select Day',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int calories = int.tryParse(_dayEntryController.text) ?? 0;
                for (int i = 0; i < listOfDays.length; i++) {
                  widget.presenter.addDailyCalorieEntry(
                      calories, listOfDays[i]);
                }
                listOfDays.clear();
                _dayEntryController.clear();
              },
              child: Text('Add Calorie Entry'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                widget.presenter.showDailyCalories();
              },
              child: Text('Show Calories per Day'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectWeekDays(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                days: _days,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    // 10% of the width, so there are ten blinds.
                    colors: [
                      const Color(0xFFE55CE4),
                      const Color(0xFFBB75FB)
                    ], // whitish to gray
                    tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                onSelect: (values) {
                  listOfDays.addAll(values);

                  print(values);
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Pop the current page (CalorieTrackerPage) off the stack and go back to the HomePage
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
