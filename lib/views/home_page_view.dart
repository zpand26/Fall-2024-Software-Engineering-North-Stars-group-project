import 'package:flutter/material.dart';
import 'package:north_stars/presenters/calorie_tracker_presenter.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
// import '/presenters/day_entry_presenter.dart';
import 'calorie_tracker_view.dart';
import 'data_entry_for_day_view.dart';
import '../models/calorie_tracker_model.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';

// Only necessary import for the MealFilter feature and Profile feature
import 'meal_filter_feature_view.dart';
import '../presenters/meal_filter_feature_presenter.dart';
import '../models/meal_filter_feature_model.dart';
import 'profile_page_view.dart';
import '../presenters/profile_page_presenter.dart';
import '../models/profile_page_model.dart';

class HomePage extends StatelessWidget {

  // Instantiate each presenter with the model and any required callbacks
  final CalorieTrackerPresenter calorieTrackerPresenter;
  final DataEntryForDayPresenter dataEntryForDayPresenter;
  final MealFilterPresenter mealFilterPresenter;
  final ProfilePagePresenter profilePagePresenter;

  HomePage({
    Key? key,
    required CalorieTrackerModel calorieTrackerModel,
    required DataEntryForDayModel dataEntryForDayModel,
  })  : calorieTrackerPresenter = CalorieTrackerPresenter(
    calorieTrackerModel,
        (data) => print(data),
  ),
        dataEntryForDayPresenter = DataEntryForDayPresenter(
          dataEntryForDayModel,
              (data) => print(data),
        ),
        mealFilterPresenter = MealFilterPresenter(MealFilterModel()),
  // Ensure ProfilePagePresenter is correctly initialized with ProfilePageModel
        profilePagePresenter = ProfilePagePresenter(
          ProfilePageModel(
            username: 'User123',
            email: 'user@example.com',
            profilePictureUrl: 'https://example.com/image.png',
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
        // Profile button in the top-left corner
        leading: IconButton(
          icon: const Icon(Icons.person, size:30.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePageView(
                  presenter: profilePagePresenter,
                ),
              ),
            );
          },
        ),
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
            // Navigate to Meal Filter Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MealFilterFeature(mealFilterPresenter: mealFilterPresenter),
                  ),
                );
              },
              child: const Text("Go to Meal Filter"),
            ),
            // Navigate to Calorie Tracker Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CalorieTrackingView(calorieTrackerPresenter),
                  ),
                );
              },
              child: const Text('Go to Calorie Tracker'),
            ),
          ],
        ),
      ),
    );
  }
}
