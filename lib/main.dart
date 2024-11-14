import 'package:flutter/material.dart';
import 'models/notification_model.dart';
import 'presenters/notification_presenter.dart';
import 'views/notification_view.dart';
import 'notification/home.dart';
import 'notification/initialization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'models/calorie_tracker_model.dart';
import 'presenters/calorie_tracker_presenter.dart';
import 'views/home_page_view.dart';
import 'package:galleryimage/galleryimage.dart';
import 'models/photo_gallery_model.dart';
import 'presenters/photo_gallery_presenter.dart';
import 'views/photo_gallery_view.dart';



void main() async {
  await initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CalorieTrackerModel calorieTrackerModel = CalorieTrackerModel();
  final DataEntryForDayModel dataEntryForDayModel = DataEntryForDayModel();
  final PhotoGalleryPresenter photoGalleryPresenter = PhotoGalleryPresenter(PhotoGalleryModel());
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
              photoGalleryPresenter: photoGalleryPresenter,
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

