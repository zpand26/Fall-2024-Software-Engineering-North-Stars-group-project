import 'package:flutter/material.dart';
import 'package:north_stars/models/nutrient_tracking_model.dart';
import 'package:north_stars/views/login_page_view.dart';
import 'notification/initialization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'models/calorie_tracker_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'presenters/calorie_tracker_presenter.dart';
import 'views/home_page_view.dart';
import 'package:galleryimage/galleryimage.dart';
import 'models/photo_gallery_model.dart';
import 'presenters/photo_gallery_presenter.dart';
import 'views/photo_gallery_view.dart';
//import 'package:north_stars/presenters/notification_presenter.dart';




void main() async {
  await initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final NutrientTrackerModel nutrientTrackerModel = NutrientTrackerModel();
  final CalorieTrackerModel calorieTrackerModel = CalorieTrackerModel();
  final DataEntryForDayModel dataEntryForDayModel = DataEntryForDayModel();
  final PhotoGalleryPresenter photoGalleryPresenter = PhotoGalleryPresenter(
    PhotoGalleryModel(),
        () {
      print("Photo gallery view updated");
    },
      FirebaseAuth.instance.currentUser?.uid ?? ''


  );
  MyApp({super.key});
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
          return const MaterialApp(
            home: AuthPage(),
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
