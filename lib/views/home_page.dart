import 'package:flutter/material.dart';
import 'package:north_stars/presenters/nutrient_tracking_presenter.dart';
import 'package:north_stars/views/nutrient_tracking_view.dart';
import '../presenters/calorie_tracker_presenter.dart';
import 'calorie_tracking_page.dart';
import 'data_entry_for_day.dart';
import '../models/model.dart';
import '../models/nutrient_tracking_model.dart';



class HomePage extends StatelessWidget {
  final NutrientTrackingModel model;

  HomePage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalorieTrackerPresenter presenter = CalorieTrackerPresenter(model, (data) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Navigate to DataEntry Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DayEntryPage(presenter),
                  ),
                );
              },
              child: const Text('Enter data by day'),
            ),
            ElevatedButton(
              //Navigate to Calorie Tracker Page
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalorieTrackerPage(presenter),
                  ),
                );
              },
              child: const Text('Go to Calorie Tracker'),
            ),
            ElevatedButton(
              //Navigate to Calorie Tracker Page
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NutrientTrackerModel(model,updateView), 
                      
                      ),
                    );
                  },
              
              child: const Text('Go to Nutrient Tracking'),
            ),
          ],
        ),
      ),
    );
  }
}