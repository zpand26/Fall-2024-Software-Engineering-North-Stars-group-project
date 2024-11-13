import 'package:flutter/material.dart';
import 'package:north_stars/presenters/calorie_tracker_presenter.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
import 'package:north_stars/views/calendar_view.dart';
import 'calorie_tracker_view.dart';
import 'data_entry_for_day_view.dart';
import '../models/calorie_tracker_model.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'package:north_stars/views/nutrient_tracking_view.dart';
import 'package:north_stars/presenters/nutrient_tracking_presenter.dart';
import 'package:north_stars/models/nutrient_tracking_model.dart';
import 'notification_home.dart';
import 'notification_settings_page.dart';

import 'package:north_stars/views/nutrition_goal_view.dart';
import 'package:north_stars/models/nutrition_goal_model.dart';
import 'package:north_stars/presenters/nutrition_goal_presenter.dart';


class HomePage extends StatelessWidget {
  // Instantiate each presenter with the model and any required callbacks
  final CalorieTrackerPresenter calorieTrackerPresenter;
  final DataEntryForDayPresenter dataEntryForDayPresenter;
  final NutrientTrackingPresenter nutrientTrackingPresenter;
  //final notificationPresenter notificationPresenter;
  final String nutrientData = "No nutrient data loaded";

  final NutritionGoalPresenter nutritionGoalPresenter;

  HomePage({
    super.key,
    required CalorieTrackerModel calorieTrackerModel,
    required DataEntryForDayModel dataEntryForDayModel,
    required NutrientTrackerModel nutrientTrackerModel,
    required NutritionGoalModel nutritionGoalModel, 
    // required NotificationService notificationService,
  })  : calorieTrackerPresenter = CalorieTrackerPresenter(
    calorieTrackerModel,
        (data) => print(data),
  ),
        dataEntryForDayPresenter = DataEntryForDayPresenter(
          dataEntryForDayModel,
              (data) => print(data),
        ),
        nutrientTrackingPresenter = NutrientTrackingPresenter(
          nutrientTrackerModel,
              (data) => print(data),
        ), 

        nutritionGoalPresenter = NutritionGoalPresenter(
          // model: nutritionGoalModel,
          // onUpdate: (data) => print(data),
          // nutritionGoalModel,
          // (data) => print(data),
        
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String choice) {
              if (choice == 'Notifications') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationHome()),
                );
              } else if (choice == 'Settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Notifications', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Navigate to DataEntry Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DayEntryPage(dataEntryForDayPresenter),
                  ),
                );
              },
              child: const Text('Enter data by day'),
            ),
            ElevatedButton(
              // Navigate to Calorie Tracker Page
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalorieTrackerView(calorieTrackerPresenter),
                  ),
                );
              },
              child: const Text('Go to Calorie Tracker'),
            ),
            ElevatedButton(
              // Navigate to Nutrient Tracker Page
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NutrientTrackingView(nutrientTrackingPresenter),
                  ),
                );
              },
              child: const Text('Go to Nutrient Tracker'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context, 
            //       MaterialPageRoute(builder: (context) => CalendarScreen(),
            //       ),
            //     );
            //   },
            //     child: const Text('View Calendar'),
            //     ),

            // _buildNavigationButton(
            //   context,
            //   'View Calendar',
            //   () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => CalendarScreen(),
            //     ),
            //   ),
            // ),
              _buildNavigationButton(
                  context,
                  'Nutrition Goals (Intake Summary)',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: 
                    (context) => NutritionGoalView(),
                    ),
                  ),
                )
            // ElevatedButton(
            //   // Navigate to Nutrient Tracker Page
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => NotificationView(notificationPresenter),
            //       ),
            //     );
            //   },
            //   child: const Text('Go to Notification Service'),
            // ),
          ],
        ),
      ),
    );
  }
}

// navigation button for calendar
Widget _buildNavigationButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
// SettingsPage Widget
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationSettingsPage()),
            );
          },
          child: const Text('Notification Settings'),
        ),
      ),
    );
  }
}