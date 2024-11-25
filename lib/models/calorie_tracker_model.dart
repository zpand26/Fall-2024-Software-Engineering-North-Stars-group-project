
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalorieTrackerModel {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get current users ID
  String get userId => _auth.currentUser?.uid ?? '';


  //add calories to firebase
  Future<void> addCalories(int calorie, int year, int month, int day) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('year')
          .doc(year.toString())
          .collection('month')
          .doc(month.toString())
          .collection('day')
          .doc(day.toString())
          .collection('Calories')
          .add({'calorie': calorie, 'timestamp': DateTime.now()});
    }
  }

  //add Fat to firebase
  Future<void> addFat(int Fat, int year, int month, int day) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('year')
          .doc(year.toString())
          .collection('month')
          .doc(month.toString())
          .collection('day')
          .doc(day.toString())
          .collection('Fat')
          .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
    }
  }

  //add Cholesterol to firebase
  Future<void> addCholesterol(int cholesterol, int year, int month, int day) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('year')
          .doc(year.toString())
          .collection('month')
          .doc(month.toString())
          .collection('day')
          .doc(day.toString())
          .collection('Cholesterol')
          .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
    }
  }

  //add Sodium to firebase
  Future<void> addSodium(int sodium, int year, int month, int day) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('year')
          .doc(year.toString())
          .collection('month')
          .doc(month.toString())
          .collection('day')
          .doc(day.toString())
          .collection('Sodium')
          .add({'Sodium': sodium, 'timestamp': DateTime.now()});
    }
  }

  //add Carbs to firebase
  Future<void> addCarbs(int carbs, int year, int month, int day) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('year')
          .doc(year.toString())
          .collection('month')
          .doc(month.toString())
          .collection('day')
          .doc(day.toString())
          .collection('Carbohydrates')
          .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
    }
  }

  //add Fiber to firebase
  Future<void> addFiber(int fiber, int year, int month,  int day) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('year')
          .doc(year.toString())
          .collection('month')
          .doc(month.toString())
          .collection('day')
          .doc(day.toString())
          .collection('Fiber')
          .add({'Fiber': fiber, 'timestamp': DateTime.now()});
    }
  }

  //add Sugar to firebase
  Future<void> addSugar(int sugar, int year, int month, int day) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('year')
          .doc(year.toString())
          .collection('month')
          .doc(month.toString())
          .collection('day')
          .doc(day.toString())
          .collection('Sugar')
          .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
    }
  }

  //add Protein to firebase
  Future<void> addProtein(int protein, int year, int month, int day) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('year')
          .doc(year.toString())
          .collection('month')
          .doc(month.toString())
          .collection('day')
          .doc(day.toString())
          .collection('Protein')
          .add({'Protein': protein, 'timestamp': DateTime.now()});
    }
  }

  // Get total for a specific field on a specific day
  Future<int> getTotalForFieldOnDay(String field, int year, int month, int day) async {
    if (userId.isEmpty) return 0;

    final querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('year')
        .doc(year.toString())
        .collection('month')
        .doc(month.toString())
        .collection('day')
        .get();

    return querySnapshot.docs.fold<int>(
      0,
          (sum, doc) => sum + (doc.data()[field] as int? ?? 0),
    );
  }

  // Getters for daily totals
  Future<int> getTotalCaloriesOnDay(int year, int month, int day) =>
      getTotalForFieldOnDay('calorie', year, month, day);

  Future<int> getTotalFatOnDay(int year, int month, int day) =>
      getTotalForFieldOnDay('Total Fat', year, month, day);

  Future<int> getTotalCholesterolOnDay(int year, int month, int day) =>
      getTotalForFieldOnDay('Cholesterol', year, month, day);

  Future<int> getTotalSodiumOnDay(int year, int month, int day) =>
      getTotalForFieldOnDay('Sodium', year, month, day);

  Future<int> getTotalCarbsOnDay(int year, int month, int day) =>
      getTotalForFieldOnDay('Total Carbohydrates', year, month, day);

  Future<int> getTotalFiberOnDay(int year, int month, int day) =>
      getTotalForFieldOnDay('Fiber', year, month, day);

  Future<int> getTotalSugarOnDay(int year, int month, int day) =>
      getTotalForFieldOnDay('Total Sugar', year, month, day);

  Future<int> getTotalProteinOnDay(int year, int month, int day) =>
      getTotalForFieldOnDay('Protein', year, month, day);
}