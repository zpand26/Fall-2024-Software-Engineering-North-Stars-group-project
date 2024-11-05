import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/model.dart';
import 'presenters/calorie_tracker_presenter.dart';
import 'views/home_page.dart';




=======
import 'nutrient_tracking_model.dart';
import 'nutrient_tracking_presenter.dart';
import 'nutrient_tracking_view.dart';
>>>>>>> feature-nutrient-tracking
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< HEAD
  final AppModel model = AppModel();
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



=======
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking Your Nutrients',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nutrientData = "No nutrient data loaded";

  @override
  Widget build(BuildContext context) {
    // Initialize the model and presenter here
    final model = AppModel();
    final presenter = AppPresenter(model, updateView);

    // Pass `nutrientData` to AppView as required
    return AppView(presenter, data: nutrientData);
  }

  void updateView(String newData) {
    setState(() {
      nutrientData = newData;
    });
  }
}
>>>>>>> feature-nutrient-tracking
