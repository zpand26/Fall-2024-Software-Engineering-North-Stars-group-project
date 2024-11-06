import 'package:flutter/material.dart';
import '../presenters/calorie_tracker_presenter.dart';

class CalorieTrackerView extends StatefulWidget {
  final CalorieTrackerPresenter calorieTrackerPresenter;

  const CalorieTrackerView(this.calorieTrackerPresenter, {super.key});

  @override
  _CalorieTrackerViewState createState() => _CalorieTrackerViewState();
}

class _CalorieTrackerViewState extends State<CalorieTrackerView> {
  final TextEditingController _calorieController = TextEditingController();
  String _displayMessage = ''; // Variable to store the message from presenter

  @override
  void initState() {
    super.initState();
    // Initialize the updateView callback
    widget.calorieTrackerPresenter.updateView = (String message) {
      setState(() {
        _displayMessage = message;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _calorieController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Calories',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int calories = int.tryParse(_calorieController.text) ?? 0;
                widget.calorieTrackerPresenter.addSolidCalorieEntry(calories);
                _calorieController.clear();
              },
              child: Text('Add Solid Calorie Entry'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int calories = int.tryParse(_calorieController.text) ?? 0;
                widget.calorieTrackerPresenter.addLiquidCalorieEntry(calories);
                _calorieController.clear();
              },
              child: Text('Add Liquid Calorie Entry'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                widget.calorieTrackerPresenter.showTotalLiquidCalories();
              },
              child: Text('Show Total Liquid Calories'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                widget.calorieTrackerPresenter.showTotalSolidCalories();
              },
              child: Text('Show Total Solid Calories'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                widget.calorieTrackerPresenter.showTotalCalories();
              },
              child: Text('Show Total Calories'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Pop the current page (CalorieTrackerPage) off the stack and go back to the HomePage
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: Text('Back to Home'),
            ),
            SizedBox(height: 20.0),
            // Display the message received from the presenter
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
