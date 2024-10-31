import 'package:flutter/material.dart';
import '../presenter.dart';
import 'calorie_tracking_page.dart';
import 'data_entry_for_day.dart';
import '../model.dart';



class HomePage extends StatelessWidget {
  final AppModel model;

  HomePage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppPresenter presenter = AppPresenter(model, (data) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Navigate to DataEntry Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DayEntryPage(presenter),
                  ),
                );
              },
              child: const Text('Enter data by day'),
            ),
            ElevatedButton(
              //Navigate to Calorie Tracker Page
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalorieTrackerPage(presenter),
                  ),
                );
              },
              child: const Text('Go to Calorie Tracker'),
            ),
          ],
        ),
      ),
    );
  }
}