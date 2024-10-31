import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model.dart';
import 'presenter.dart';
import 'view.dart';
import 'data_entry_for_day.dart';
import 'calorie_tracking_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //const MyApp({Key? key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    // Initialize Model and Presenter
    AppModel model = AppModel();
    AppPresenter presenter;
    //Initialize FlutterFire
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
        //Check for errors
        if (snapshot.hasError){
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text("Couldn't Connect to Firebase")),
            ),
          );
        }
        //Once complete, show application
        if (snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            home: HomePage(model: model),
          );
        }
        //loading indicator
        return const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );

      });
  }
}

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

