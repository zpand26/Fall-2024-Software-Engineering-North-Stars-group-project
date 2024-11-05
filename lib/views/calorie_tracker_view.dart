import 'package:flutter/material.dart';
import '../presenters/calorie_tracker_presenter.dart';

class CalorieTrackingView extends StatefulWidget {
  final CalorieTrackerPresenter calorieTrackerPresenter;

  const CalorieTrackingView(this.calorieTrackerPresenter, {super.key});

  @override
  _CalorieTrackingViewState createState() => _CalorieTrackingViewState();
}

class _CalorieTrackingViewState extends State<CalorieTrackingView> {
  final TextEditingController _calorieController = TextEditingController();

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
          ],
        ),
      ),
    );
  }
}
