// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:north_stars/presenters/calorie_tracker_presenter.dart';
// import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
// import 'package:north_stars/views/calendar_view.dart';
// import 'calorie_tracker_view.dart';
// import 'data_entry_for_day_view.dart';
// import '../models/calorie_tracker_model.dart';
// import 'package:north_stars/models/data_entry_for_day_model.dart';
// import 'package:north_stars/views/nutrient_tracking_view.dart';
// import 'package:north_stars/presenters/nutrient_tracking_presenter.dart';
// import 'package:north_stars/models/nutrient_tracking_model.dart';
// import 'notification_home.dart';
// import 'notification_settings_page.dart';
// import 'package:north_stars/views/camera_view.dart';
// import 'profile_page_view.dart';
// import '../presenters/profile_page_presenter.dart';
// import '../models/profile_page_model.dart';
// import 'package:north_stars/views/login_page_view.dart';
// import 'package:north_stars/views/nutrition_goal_view.dart';
// import 'package:north_stars/models/nutrition_goal_model.dart';
// import 'package:north_stars/presenters/nutrition_goal_presenter.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:north_stars/views/profile_page_view.dart';
//
//
// class HomePage extends StatefulWidget {
//   final CalorieTrackerPresenter calorieTrackerPresenter;
//   final DataEntryForDayPresenter dataEntryForDayPresenter;
//   final NutrientTrackingPresenter nutrientTrackingPresenter;
//   final ProfilePagePresenter profilePagePresenter;
//   final NutritionGoalPresenter nutritionGoalPresenter;
//
//
//   HomePage({
//     super.key,
//     required CalorieTrackerModel calorieTrackerModel,
//     required DataEntryForDayModel dataEntryForDayModel,
//     required NutrientTrackerModel nutrientTrackerModel,
//     required NutritionGoalModel nutritionGoalModel,
//   }) : calorieTrackerPresenter = CalorieTrackerPresenter(calorieTrackerModel, (data) => print(data)),
//         dataEntryForDayPresenter = DataEntryForDayPresenter(dataEntryForDayModel, (data) => print(data)),
//         nutrientTrackingPresenter = NutrientTrackingPresenter(nutrientTrackerModel, (data) => print(data)),
//         profilePagePresenter = ProfilePagePresenter(
//           model: ProfilePageModel(
//             username: 'User123',
//             email: 'user@example.com',
//             profilePictureUrl: 'https://example.com/image.png',
//           ),
//           updateView: (username) {},
//         ),
//         nutritionGoalPresenter = NutritionGoalPresenter();
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//
//   late List<Widget> _pages;
//
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       CalorieTrackerView(widget.calorieTrackerPresenter),
//       DayEntryPage(widget.dataEntryForDayPresenter),
//       NutrientTrackingView(widget.nutrientTrackingPresenter),
//       NutritionGoalView(),
//       ProfilePageView(profilePagePresenter: widget.profilePagePresenter),
//     ];
//   }
//
//   void _onItemTapped(int index) {
//     Widget selectedPage;
//     switch (index) {
//       case 0:
//         selectedPage = DayEntryPage(widget.dataEntryForDayPresenter);
//         break;
//       case 1:
//         selectedPage = CalorieTrackerView(widget.calorieTrackerPresenter);
//         break;
//       case 2:
//         selectedPage = NutrientTrackingView(widget.nutrientTrackingPresenter);
//         break;
//       case 3:
//         selectedPage = ProfilePageView(profilePagePresenter: widget.profilePagePresenter);
//         break;
//       default:
//         selectedPage = DayEntryPage(widget.dataEntryForDayPresenter);
//     }
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => selectedPage),
//     );
//   }
//
//   void _onTabChanged(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   //use a singleton to implement this
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Main Menu'),
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: GNav(
//         rippleColor: Colors.grey[800]!,
//         hoverColor: Colors.grey[700]!,
//         haptic: true,
//         tabBorderRadius: 15,
//         tabActiveBorder: Border.all(color: Colors.black, width: 1),
//         tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)],
//         curve: Curves.easeOutExpo,
//         duration: const Duration(milliseconds: 900),
//         gap: 8,
//         color: Colors.grey[800],
//         activeColor: Colors.purple,
//         iconSize: 24,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         tabs: const [
//           GButton(
//             icon: LineIcons.fire,
//             text: 'Calories',
//           ),
//           GButton(
//             icon: LineIcons.calendar,
//             text: 'Data Entry',
//           ),
//           GButton(
//             icon: LineIcons.apple,
//             text: 'Nutrients',
//           ),
//           GButton(
//             icon: LineIcons.heart,
//             text: 'Goals',
//           ),
//           GButton(
//             icon: LineIcons.user,
//             text: 'Profile',
//           ),
//         ],
//         selectedIndex: _selectedIndex,
//         onTabChange: _onItemTapped,
//       ),
//     );
//   }
// }