import 'package:flutter/material.dart';
import 'package:north_stars/presenters/calorie_tracker_presenter.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
import 'calorie_tracker_view.dart';
import 'data_entry_for_day_view.dart';
import '../models/calorie_tracker_model.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';

// Necessary imports for MealFilter and ProfilePage features
import 'meal_filter_feature_view.dart';
import '../presenters/meal_filter_feature_presenter.dart';
import '../models/meal_filter_feature_model.dart';
import 'profile_page_view.dart';
import '../presenters/profile_page_presenter.dart';
import '../models/profile_page_model.dart';

class HomePage extends StatelessWidget {
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
        profilePagePresenter = ProfilePagePresenter(
          model: ProfilePageModel(
            username: 'User123',
            email: 'user@example.com',
            profilePictureUrl: 'https://example.com/image.png',
          ),
          updateView: (username) {},
        ),
        super(key: key);

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
                    builder: (context) =>
                        MealFilterFeature(mealFilterPresenter: mealFilterPresenter),
                  ),
                );
              },
              child: const Text("Go to Meal Filter"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalorieTrackingView(calorieTrackerPresenter),
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
