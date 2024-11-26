import 'package:flutter/material.dart';
import 'package:day_picker/day_picker.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
import '../presenters/calorie_tracker_presenter.dart';

class DayEntryView extends StatefulWidget {
  final DataEntryForDayPresenter dataEntryForDayPresenter;

  const DayEntryView(this.dataEntryForDayPresenter, {super.key});

  @override
  _dayEntryViewState createState() => _dayEntryViewState();
}

final List<DayInWeek> _days = [
  DayInWeek("Mon", dayKey: "mon", isSelected: false),
  DayInWeek("Tue", dayKey: "tue", isSelected: false),
  DayInWeek("Wed", dayKey: "wed", isSelected: false),
  DayInWeek("Thu", dayKey: "thu", isSelected: false),
  DayInWeek("Fri", dayKey: "fri", isSelected: false),
  DayInWeek("Sat", dayKey: "sat", isSelected: false),
  DayInWeek("Sun", dayKey: "sun", isSelected: false),
];

List<String> listOfDays = [];

class _dayEntryViewState extends State<DayEntryView> {
  final TextEditingController _dayEntryController = TextEditingController();
  String _displayMessage = ''; //Stores message from presenter

  @override
  void initState(){
    super.initState();
    //Initialize updateView callback
    widget.dataEntryForDayPresenter.updateView = (String message){
      setState((){
        _displayMessage = message;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    final customWidgetKey = GlobalKey<SelectWeekDaysState>();

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
        title: const Text('Daily Calories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _dayEntryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Calories and Select Day',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int calories = int.tryParse(_dayEntryController.text) ?? 0;
                for (int i = 0; i < listOfDays.length; i++) {
                  widget.dataEntryForDayPresenter.addDailyCalorieEntry(
                      calories, listOfDays[i]);
                }
                _dayEntryController.clear();
              },
              child: const Text('Add Calorie Entry'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                widget.dataEntryForDayPresenter.showDailyCalories();
              },
              child: const Text('Show Calories per Day'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectWeekDays(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                days: _days,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    // 10% of the width, so there are ten blinds.
                    colors: [
                      Color(0xFFE55CE4),
                      Color(0xFFBB75FB)
                    ], // whitish to gray
                    tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                onSelect: (values) {
                  listOfDays = values;

                  print(values); //Tests value selector in terminal
                  print(listOfDays);
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Pop the current page (CalorieTrackerPage) off the stack and go back to the HomePage
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent),
              child: const Text('Back to Home'),
            ),
            SizedBox (height: 20.0),
            Text(
              _displayMessage,
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}