import 'package:flutter/material.dart';
import 'meal_filter_feature.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Filter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MealFilterFeature(),
    );
  }
}
