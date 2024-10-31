import 'package:flutter/material.dart';
import 'model.dart';
import 'presenter.dart';
import 'view.dart';
import 'notification/home.dart';
import 'notification/initialization.dart';

void main() async {
  await initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize Model and Presenter
    AppModel model = AppModel();
    AppPresenter presenter;

    return MaterialApp(
      home: Builder(
        builder: (context) {
          // Connect the Presenter to the View
          presenter = AppPresenter(model, (data) {
            // Display the data as a SnackBar for simplicity
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data)),
            );
          });
          return AppView(presenter);  // Pass presenter to AppView
        },
      ),
    );
  }
}
