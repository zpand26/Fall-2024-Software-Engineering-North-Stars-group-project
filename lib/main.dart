import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'models/calorie_tracker_model.dart';
import 'presenters/calorie_tracker_presenter.dart';
import 'views/home_page_view.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CalorieTrackerModel calorieTrackerModel = CalorieTrackerModel();
  final DataEntryForDayModel dataEntryForDayModel = DataEntryForDayModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: Text("Couldn't connect to Firebase")),
              ),
            );
          }
        //Once complete, show application
        if (snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            home: HomePage(
              calorieTrackerModel: calorieTrackerModel,
              dataEntryForDayModel: dataEntryForDayModel,
            ),
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



