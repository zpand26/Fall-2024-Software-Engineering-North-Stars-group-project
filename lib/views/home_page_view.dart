import 'package:flutter/material.dart';
import 'package:north_stars/presenters/calorie_tracker_presenter.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
import 'calorie_tracker_view.dart';
import 'data_entry_for_day_view.dart';
import '../models/calorie_tracker_model.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'package:north_stars/views/nutrient_tracking_view.dart';
import 'package:north_stars/presenters/nutrient_tracking_presenter.dart';
import 'package:north_stars/models/nutrient_tracking_model.dart';
import 'notification_home.dart';
import 'notification_settings_page.dart';
import 'package:north_stars/views/camera_view.dart';
import 'profile_page_view.dart';
import '../presenters/profile_page_presenter.dart';
import '../models/profile_page_model.dart';

class HomePage extends StatelessWidget {
  // Instantiate each presenter with the model and any required callbacks
  final CalorieTrackerPresenter calorieTrackerPresenter;
  final DataEntryForDayPresenter dataEntryForDayPresenter;
  final NutrientTrackingPresenter nutrientTrackingPresenter;
  final ProfilePagePresenter profilePagePresenter;
  final String nutrientData = "No nutrient data loaded";

  HomePage({
    super.key,
    required CalorieTrackerModel calorieTrackerModel,
    required DataEntryForDayModel dataEntryForDayModel,
    required NutrientTrackerModel nutrientTrackerModel,
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
        profilePagePresenter = ProfilePagePresenter(
          model: ProfilePageModel(
            username: 'User123',
            email: 'user@example.com',
            profilePictureUrl: 'https://example.com/image.png',
          ),
          updateView: (username) {},
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
        leading: IconButton(
          icon: const Icon(Icons.person, size: 30.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePageView(presenter: profilePagePresenter),
              ),
            );
          },
        ),
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
      // Wrapping body in a Stack for positioning
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                // Uncomment and add more buttons as needed
                // ElevatedButton(
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
          // Positioned widget for camera button in bottom-left corner
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(), // Ensure CameraScreen is imported
                  ),
                );
              },
              child: Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
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
