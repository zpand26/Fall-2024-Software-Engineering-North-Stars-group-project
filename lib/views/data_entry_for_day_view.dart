import 'package:flutter/material.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
import 'package:north_stars/presenters/calorie_tracker_presenter.dart';
import 'package:day_picker/day_picker.dart';

class DayEntryView extends StatefulWidget {
  final DataEntryForDayPresenter dataEntryForDayPresenter;

  const DayEntryView(this.dataEntryForDayPresenter, {super.key});

  @override
  _DayEntryViewState createState() => _DayEntryViewState();
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
String selectedWeek = 'Week 1';  // Default selected week

class _DayEntryViewState extends State<DayEntryView> {
  final TextEditingController _dayEntryController = TextEditingController();
  String _displayMessage = ''; // Stores message from presenter

  @override
  void initState() {
    super.initState();
    // Initialize the updateView callback
    widget.dataEntryForDayPresenter.updateView = (String message) {
      setState(() {
        _displayMessage = message;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Calories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Week selection dropdown
            DropdownButton<String>(
              value: selectedWeek,
              onChanged: (String? newWeek) {
                setState(() {
                  selectedWeek = newWeek!;
                });
              },
              items: ['Week 1', 'Week 2', 'Week 3', 'Week 4']
                  .map<DropdownMenuItem<String>>((String week) {
                return DropdownMenuItem<String>(
                  value: week,
                  child: Text(week),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),

            // Text field for entering calories
            TextField(
              controller: _dayEntryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Calories and Select Day',
              ),
            ),
            const SizedBox(height: 16.0),

            // Button to add calorie entry for the selected days
            ElevatedButton(
              onPressed: () {
                int calories = int.tryParse(_dayEntryController.text) ?? 0;
                for (String day in listOfDays) {
                  widget.dataEntryForDayPresenter.addDailyCalorieEntry(
                      calories, day, selectedWeek);
                }
                _dayEntryController.clear();
              },
              child: const Text('Add Calorie Entry'),
            ),
            const SizedBox(height: 16.0),

            // Button to show daily calories for the selected week
            ElevatedButton(
              onPressed: () {
                widget.dataEntryForDayPresenter.showDailyCalories(selectedWeek);
              },
              child: const Text('Show Calories per Day'),
            ),
            const SizedBox(height: 16.0),

            // Weekday selector for picking days
            SelectWeekDays(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)],
                  tileMode: TileMode.repeated,
                ),
              ),
              onSelect: (values) {
                listOfDays = values;
                print('Selected Days: $values');
              },
            ),
            const SizedBox(height: 16.0),

            // Button to navigate back to the home page
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 20.0),

            // Display the message from the presenter
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
