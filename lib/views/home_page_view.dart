import 'package:flutter/material.dart';
import 'package:north_stars/models/notification_model.dart';
import 'package:north_stars/presenters/calorie_tracker_presenter.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
import 'package:north_stars/views/notification_view.dart';
import 'calorie_tracker_view.dart';
import 'data_entry_for_day_view.dart';
import '../models/calorie_tracker_model.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'package:north_stars/views/nutrient_tracking_view.dart';
import 'package:north_stars/presenters/nutrient_tracking_presenter.dart';
import 'package:north_stars/models/nutrient_tracking_model.dart';




class HomePage extends StatelessWidget {
  // Instantiate each presenter with the model and any required callbacks
  final CalorieTrackerPresenter calorieTrackerPresenter;
  final DataEntryForDayPresenter dataEntryForDayPresenter;
  final NutrientTrackingPresenter nutrientTrackingPresenter;
  //final notificationPresenter notificationPresenter;
  final String nutrientData = "No nutrient data loaded";

  HomePage({
    Key? key,
    required CalorieTrackerModel calorieTrackerModel,
    required DataEntryForDayModel dataEntryForDayModel,
    required NutrientTrackerModel nutrientTrackerModel,
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
        // notificationPresenter = NotificationPresenter(
        //   notificationService,
        //       (data) => print(data),
        // ),
        super(key: key);

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
                  MaterialPageRoute(builder: (context) => NotificationView()),
                );

              }
            },
            itemBuilder: (BuildContext context) {
              return {'Notifications'}.map((String choice) {
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
