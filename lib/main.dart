import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model.dart';
import 'presenter.dart';
import 'view.dart';
import 'pages/data_entry_for_day.dart';
import 'pages/calorie_tracking_page.dart';
import 'pages/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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



