import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:north_stars/presenters/login_page_presenter.dart';
import 'package:north_stars/views/home_page_view1.dart';
import 'package:north_stars/models/calorie_tracker_model.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'package:north_stars/models/nutrient_tracking_model.dart';
import 'package:north_stars/models/nutrition_goal_model.dart';
import 'package:north_stars/views/nav_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> implements AuthViewContract {
  late AuthPresenter _presenter;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true;

  // Future<void> _authenticate() async {
  //   try {
  //     UserCredential userCredential;
  //     if (_isLogin) {
  //       userCredential = await _auth.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //     } else {
  //       userCredential = await _auth.createUserWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //     }

  @override
  void initState() {
    super.initState();
    _presenter = AuthPresenter(this);
  }

  void _authenticate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (_isLogin) {
      _presenter.login(email, password);
    } else {
      _presenter.signUp(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text(_isLogin ? 'Login' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? 'Create an account' : 'Have an account? Log in'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => NavBar(
          calorieTrackerModel: CalorieTrackerModel(),
          dataEntryForDayModel: DataEntryForDayModel(),
          nutrientTrackerModel: NutrientTrackerModel(),
          nutritionGoalModel: NutritionGoalModel(),
        ),
      ),
    );
  }

  @override
  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => AuthPage(),
      ),
    );
  }
}
