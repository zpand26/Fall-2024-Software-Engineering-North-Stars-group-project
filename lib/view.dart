import 'package:flutter/material.dart';
import 'presenter.dart';

class AppView extends StatelessWidget {
  final AppPresenter presenter;

  AppView(this.presenter);

  @override
  Widget build(BuildContext context) {
    TextEditingController calorieController = TextEditingController();

    // Define a function to update the UI
    void updateMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    // Assign updateMessage function to presenter
    presenter.updateView = updateMessage;

    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: calorieController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter Calories',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  int calorie = int.tryParse(calorieController.text) ?? 0;
                  presenter.addCalorieEntry(calorie);
                },
                child: Text('Add Calories'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  int calorie = int.tryParse(calorieController.text) ?? 0;
                  presenter.removeCalorieEntry(calorie);
                },
                child: Text('Remove Calories'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}