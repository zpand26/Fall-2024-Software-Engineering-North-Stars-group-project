import 'package:flutter/material.dart';
import '../presenter.dart';
import 'calorie_tracking_page.dart';
import 'data_entry_for_day.dart';
import '../model.dart';



class HomePage extends StatelessWidget {
  final AppModel model;

  const HomePage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    AppPresenter presenter = AppPresenter(model, (data) {
      // Show a SnackBar to display messages
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data)),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton( //DataTrackerByDay
                onPressed: () {
                  //Navigate to dayEntryPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) => dayEntryPage(presenter),
                    ),
                  );
                },
                child: const Text('Enter data by day')
            ),
            ElevatedButton( //Calorie Tracker button
              onPressed: () {
                // Navigate to Calorie Tracker Page
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