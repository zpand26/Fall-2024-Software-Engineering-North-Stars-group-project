import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:north_stars/presenters/calorie_tracker_presenter.dart';
import 'package:north_stars/presenters/camera_presenter.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
import 'package:north_stars/presenters/photo_gallery_presenter.dart';
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
import 'package:north_stars/views/camera_view.dart';
import 'profile_page_view.dart';
import '../presenters/profile_page_presenter.dart';
import '../models/profile_page_model.dart';
import 'package:north_stars/views/login_page_view.dart';
import 'package:north_stars/views/nutrition_goal_view.dart';
import 'package:north_stars/models/nutrition_goal_model.dart';
import 'package:north_stars/presenters/nutrition_goal_presenter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:north_stars/views/profile_page_view.dart';
import 'package:north_stars/presenters/calendar_presenter.dart';
import 'package:north_stars/models/camera_model.dart';
import 'package:north_stars/presenters/photo_gallery_presenter.dart';
import 'package:north_stars/models/photo_gallery_model.dart';


class NavBar extends StatefulWidget {
  final CalorieTrackerPresenter calorieTrackerPresenter;
  final DataEntryForDayPresenter dataEntryForDayPresenter;
  final NutrientTrackingPresenter nutrientTrackingPresenter;
  final ProfilePagePresenter profilePagePresenter;
  final NutritionGoalPresenter nutritionGoalPresenter;
  final PhotoGalleryPresenter photoGalleryPresenter;
  //final CalendarScreenPresenter calenderScreenPresenter;


  NavBar({
    super.key,
    required CalorieTrackerModel calorieTrackerModel,
    required DataEntryForDayModel dataEntryForDayModel,
    required NutrientTrackerModel nutrientTrackerModel,
    required NutritionGoalModel nutritionGoalModel,
    required PhotoGalleryModel photoGalleryModel,
  }) : calorieTrackerPresenter = CalorieTrackerPresenter(calorieTrackerModel, (data) => print(data)),
        dataEntryForDayPresenter = DataEntryForDayPresenter(dataEntryForDayModel, (data) => print(data)),
        nutrientTrackingPresenter = NutrientTrackingPresenter(nutrientTrackerModel, (data) => print(data)),
        profilePagePresenter = ProfilePagePresenter(
          model: ProfilePageModel(
            username: 'User123',
            email: 'user@example.com',
            profilePictureUrl: 'https://example.com/image.png',
          ),
          updateView: (username) {},
        ),
        nutritionGoalPresenter = NutritionGoalPresenter(),
        photoGalleryPresenter = PhotoGalleryPresenter(photoGalleryModel);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      NutritionGoalView(),
      NutrientTrackingView(widget.nutrientTrackingPresenter),
      CameraScreen(),
      ProfilePageView(profilePagePresenter: widget.profilePagePresenter),
      NotificationHome(),
    ];
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex], // Display the selected page

          // Optional Logout Button
          Positioned(
            top: 40,
            right: 20,
            child: FloatingActionButton.small(
              onPressed: _logout,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          haptic: true,
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(color: Colors.black, width: 1),
          tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)],
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 200),
          gap: 8,
          color: Colors.grey[800],
          activeColor: Colors.blue,
          iconSize: 24,
          tabBackgroundColor: Colors.blue.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: LineIcons.calendar,
              // text: 'Entry',
            ),
            GButton(
              icon: LineIcons.apple,
              // text: 'Nutrients',
            ),
            GButton(
              icon: LineIcons.camera,
              // text: 'Camera',
            ),
            GButton(
              icon: LineIcons.user,
              // text: 'Profile',
            ),
            GButton(
              icon: LineIcons.cog,
              // text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

