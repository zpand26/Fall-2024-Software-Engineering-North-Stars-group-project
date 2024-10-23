import 'package:flutter/material.dart';
import 'model.dart';
import 'presenter.dart';
import 'calorie_tracking_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize Model and Presenter
    AppModel model = AppModel();
    AppPresenter presenter;

    return MaterialApp(
      home: HomePage(model: model),
    );
  }
}

class HomePage extends StatelessWidget {
  final AppModel model;

  HomePage({required this.model});

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
        title: Text('Main Menu'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to Calorie Tracker Page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalorieTrackerPage(presenter),
              ),
            );
          },
          child: Text('Go to Calorie Tracker'),
        ),
      ),
    );
  }
}
