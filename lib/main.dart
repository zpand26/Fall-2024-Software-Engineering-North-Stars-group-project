import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model.dart';
import 'presenter.dart';
import 'view.dart';
import 'data_entry_for_day.dart';
import 'calorie_tracking_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          print("couldn't connect");
        }
        //Once complete, show application
        if (snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            home: HomePage(model: model),

          );
        }
        Widget loading = MaterialApp(
          home: HomePage(model: model),
        );
        return loading;
      });
    return MaterialApp(
      home: HomePage(model:model),
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
            child: Text('Enter data by day')
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
            child: Text('Go to Calorie Tracker'),
        ),
      ],
    ),
      ),
    );
  }
}

