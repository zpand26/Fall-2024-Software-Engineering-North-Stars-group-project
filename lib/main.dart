import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/model.dart';
import 'presenters/presenter.dart';
import 'views/home_page.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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



