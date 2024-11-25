import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataEntryForDayModel {
  //sample method to fetch or proccess data
  Future<String> fetchData() async {
    //simulating a data fetch or api call
    await Future.delayed(const Duration(seconds: 2));
    return "Hello from Model!";

  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get current users ID
  String get userId => _auth.currentUser?.uid ?? '';

  late List<DateTime> dateList;
  late DateTime sunDate;
  late DateTime monDate;
  late DateTime tueDate;
  late DateTime wedDate;
  late DateTime thuDate;
  late DateTime friDate;
  late DateTime satDate;

  List<int> monCalories = [];
  List<int> tueCalories = [];
  List<int> wedCalories = [];
  List<int> thuCalories = [];
  List<int> friCalories = [];
  List<int> satCalories = [];
  List<int> sunCalories = [];

  void updateDateList(List<DateTime> updatedDateList){
    dateList = updatedDateList;
    dateList[0] = sunDate;
    dateList[1] = monDate;
    dateList[2] = tueDate;
    dateList[3] = wedDate;
    dateList[4] = thuDate;
    dateList[5] = friDate;
    dateList[6] = satDate;
  }

  bool dateListStatus(){
    if (!dateList.isEmpty){
      return true;
    }
    else{
      return false;
    }
  }

  //add calories to the list
  Future<void> addDailyCalories(int calorie, int Fat, int cholesterol,
      int sodium, int carbs, int fiber, int sugar, int protein, String dayOfWeek)
  async {
    switch (dayOfWeek) {
      case 'mon':
        //Firebase
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(monDate.year.toString())
              .collection('month')
              .doc(monDate.month.toString())
              .collection('day')
              .doc(monDate.day.toString())
              .collection('Calories')
              .add({'calorie': calorie, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(monDate.year.toString())
              .collection('month')
              .doc(monDate.month.toString())
              .collection('day')
              .doc(monDate.day.toString())
              .collection('Fat')
              .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(monDate.year.toString())
              .collection('month')
              .doc(monDate.month.toString())
              .collection('day')
              .doc(monDate.day.toString())
              .collection('Cholesterol')
              .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(monDate.year.toString())
              .collection('month')
              .doc(monDate.month.toString())
              .collection('day')
              .doc(monDate.day.toString())
              .collection('Sodium')
              .add({'Sodium': sodium, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(monDate.year.toString())
              .collection('month')
              .doc(monDate.month.toString())
              .collection('day')
              .doc(monDate.day.toString())
              .collection('Carbohydrates')
              .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(monDate.year.toString())
              .collection('month')
              .doc(monDate.month.toString())
              .collection('day')
              .doc(monDate.day.toString())
              .collection('Fiber')
              .add({'Fiber': fiber, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(monDate.year.toString())
              .collection('month')
              .doc(monDate.month.toString())
              .collection('day')
              .doc(monDate.day.toString())
              .collection('Sugar')
              .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(monDate.year.toString())
              .collection('month')
              .doc(monDate.month.toString())
              .collection('day')
              .doc(monDate.day.toString())
              .collection('Protein')
              .add({'Protein': protein, 'timestamp': DateTime.now()});
        }

        monCalories.add(calorie);
      case 'tue':
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(tueDate.year.toString())
              .collection('month')
              .doc(tueDate.month.toString())
              .collection('day')
              .doc(tueDate.day.toString())
              .collection('Calories')
              .add({'calorie': calorie, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(tueDate.year.toString())
              .collection('month')
              .doc(tueDate.month.toString())
              .collection('day')
              .doc(tueDate.day.toString())
              .collection('Fat')
              .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(tueDate.year.toString())
              .collection('month')
              .doc(tueDate.month.toString())
              .collection('day')
              .doc(tueDate.day.toString())
              .collection('Cholesterol')
              .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(tueDate.year.toString())
              .collection('month')
              .doc(tueDate.month.toString())
              .collection('day')
              .doc(tueDate.day.toString())
              .collection('Sodium')
              .add({'Sodium': sodium, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(tueDate.year.toString())
              .collection('month')
              .doc(tueDate.month.toString())
              .collection('day')
              .doc(tueDate.day.toString())
              .collection('Carbohydrates')
              .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(tueDate.year.toString())
              .collection('month')
              .doc(tueDate.month.toString())
              .collection('day')
              .doc(tueDate.day.toString())
              .collection('Fiber')
              .add({'Fiber': fiber, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(tueDate.year.toString())
              .collection('month')
              .doc(tueDate.month.toString())
              .collection('day')
              .doc(tueDate.day.toString())
              .collection('Sugar')
              .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(tueDate.year.toString())
              .collection('month')
              .doc(tueDate.month.toString())
              .collection('day')
              .doc(tueDate.day.toString())
              .collection('Protein')
              .add({'Protein': protein, 'timestamp': DateTime.now()});
        }
        tueCalories.add(calorie);
      case 'wed':
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(wedDate.year.toString())
              .collection('month')
              .doc(wedDate.month.toString())
              .collection('day')
              .doc(wedDate.day.toString())
              .collection('Calories')
              .add({'calorie': calorie, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(wedDate.year.toString())
              .collection('month')
              .doc(wedDate.month.toString())
              .collection('day')
              .doc(wedDate.day.toString())
              .collection('Fat')
              .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(wedDate.year.toString())
              .collection('month')
              .doc(wedDate.month.toString())
              .collection('day')
              .doc(wedDate.day.toString())
              .collection('Cholesterol')
              .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(wedDate.year.toString())
              .collection('month')
              .doc(wedDate.month.toString())
              .collection('day')
              .doc(wedDate.day.toString())
              .collection('Sodium')
              .add({'Sodium': sodium, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(wedDate.year.toString())
              .collection('month')
              .doc(wedDate.month.toString())
              .collection('day')
              .doc(wedDate.day.toString())
              .collection('Carbohydrates')
              .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(wedDate.year.toString())
              .collection('month')
              .doc(wedDate.month.toString())
              .collection('day')
              .doc(wedDate.day.toString())
              .collection('Fiber')
              .add({'Fiber': fiber, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(wedDate.year.toString())
              .collection('month')
              .doc(wedDate.month.toString())
              .collection('day')
              .doc(wedDate.day.toString())
              .collection('Sugar')
              .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(wedDate.year.toString())
              .collection('month')
              .doc(wedDate.month.toString())
              .collection('day')
              .doc(wedDate.day.toString())
              .collection('Protein')
              .add({'Protein': protein, 'timestamp': DateTime.now()});
        }
        wedCalories.add(calorie);
      case 'thu':
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(thuDate.year.toString())
              .collection('month')
              .doc(thuDate.month.toString())
              .collection('day')
              .doc(thuDate.day.toString())
              .collection('Calories')
              .add({'calorie': calorie, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(thuDate.year.toString())
              .collection('month')
              .doc(thuDate.month.toString())
              .collection('day')
              .doc(thuDate.day.toString())
              .collection('Fat')
              .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(thuDate.year.toString())
              .collection('month')
              .doc(thuDate.month.toString())
              .collection('day')
              .doc(thuDate.day.toString())
              .collection('Cholesterol')
              .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(thuDate.year.toString())
              .collection('month')
              .doc(thuDate.month.toString())
              .collection('day')
              .doc(thuDate.day.toString())
              .collection('Sodium')
              .add({'Sodium': sodium, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(thuDate.year.toString())
              .collection('month')
              .doc(thuDate.month.toString())
              .collection('day')
              .doc(thuDate.day.toString())
              .collection('Carbohydrates')
              .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(thuDate.year.toString())
              .collection('month')
              .doc(thuDate.month.toString())
              .collection('day')
              .doc(thuDate.day.toString())
              .collection('Fiber')
              .add({'Fiber': fiber, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(thuDate.year.toString())
              .collection('month')
              .doc(thuDate.month.toString())
              .collection('day')
              .doc(thuDate.day.toString())
              .collection('Sugar')
              .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(thuDate.year.toString())
              .collection('month')
              .doc(thuDate.month.toString())
              .collection('day')
              .doc(thuDate.day.toString())
              .collection('Protein')
              .add({'Protein': protein, 'timestamp': DateTime.now()});
        }
        thuCalories.add(calorie);
      case 'fri':
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(friDate.year.toString())
              .collection('month')
              .doc(friDate.month.toString())
              .collection('day')
              .doc(friDate.day.toString())
              .collection('Calories')
              .add({'calorie': calorie, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(friDate.year.toString())
              .collection('month')
              .doc(friDate.month.toString())
              .collection('day')
              .doc(friDate.day.toString())
              .collection('Fat')
              .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(friDate.year.toString())
              .collection('month')
              .doc(friDate.month.toString())
              .collection('day')
              .doc(friDate.day.toString())
              .collection('Cholesterol')
              .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(friDate.year.toString())
              .collection('month')
              .doc(friDate.month.toString())
              .collection('day')
              .doc(friDate.day.toString())
              .collection('Sodium')
              .add({'Sodium': sodium, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(friDate.year.toString())
              .collection('month')
              .doc(friDate.month.toString())
              .collection('day')
              .doc(friDate.day.toString())
              .collection('Carbohydrates')
              .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(friDate.year.toString())
              .collection('month')
              .doc(friDate.month.toString())
              .collection('day')
              .doc(friDate.day.toString())
              .collection('Fiber')
              .add({'Fiber': fiber, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(friDate.year.toString())
              .collection('month')
              .doc(friDate.month.toString())
              .collection('day')
              .doc(friDate.day.toString())
              .collection('Sugar')
              .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(friDate.year.toString())
              .collection('month')
              .doc(friDate.month.toString())
              .collection('day')
              .doc(friDate.day.toString())
              .collection('Protein')
              .add({'Protein': protein, 'timestamp': DateTime.now()});
        }
        friCalories.add(calorie);
      case 'sat':
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(satDate.year.toString())
              .collection('month')
              .doc(satDate.month.toString())
              .collection('day')
              .doc(satDate.day.toString())
              .collection('Calories')
              .add({'calorie': calorie, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(satDate.year.toString())
              .collection('month')
              .doc(satDate.month.toString())
              .collection('day')
              .doc(satDate.day.toString())
              .collection('Fat')
              .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(satDate.year.toString())
              .collection('month')
              .doc(satDate.month.toString())
              .collection('day')
              .doc(satDate.day.toString())
              .collection('Cholesterol')
              .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(satDate.year.toString())
              .collection('month')
              .doc(satDate.month.toString())
              .collection('day')
              .doc(satDate.day.toString())
              .collection('Sodium')
              .add({'Sodium': sodium, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(satDate.year.toString())
              .collection('month')
              .doc(satDate.month.toString())
              .collection('day')
              .doc(satDate.day.toString())
              .collection('Carbohydrates')
              .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(satDate.year.toString())
              .collection('month')
              .doc(satDate.month.toString())
              .collection('day')
              .doc(satDate.day.toString())
              .collection('Fiber')
              .add({'Fiber': fiber, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(satDate.year.toString())
              .collection('month')
              .doc(satDate.month.toString())
              .collection('day')
              .doc(satDate.day.toString())
              .collection('Sugar')
              .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(satDate.year.toString())
              .collection('month')
              .doc(satDate.month.toString())
              .collection('day')
              .doc(satDate.day.toString())
              .collection('Protein')
              .add({'Protein': protein, 'timestamp': DateTime.now()});
        }
        satCalories.add(calorie);
      case 'sun':
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(sunDate.year.toString())
              .collection('month')
              .doc(sunDate.month.toString())
              .collection('day')
              .doc(sunDate.day.toString())
              .collection('Calories')
              .add({'calorie': calorie, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(sunDate.year.toString())
              .collection('month')
              .doc(sunDate.month.toString())
              .collection('day')
              .doc(sunDate.day.toString())
              .collection('Fat')
              .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(sunDate.year.toString())
              .collection('month')
              .doc(sunDate.month.toString())
              .collection('day')
              .doc(sunDate.day.toString())
              .collection('Cholesterol')
              .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(sunDate.year.toString())
              .collection('month')
              .doc(sunDate.month.toString())
              .collection('day')
              .doc(sunDate.day.toString())
              .collection('Sodium')
              .add({'Sodium': sodium, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(sunDate.year.toString())
              .collection('month')
              .doc(sunDate.month.toString())
              .collection('day')
              .doc(sunDate.day.toString())
              .collection('Carbohydrates')
              .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(sunDate.year.toString())
              .collection('month')
              .doc(sunDate.month.toString())
              .collection('day')
              .doc(sunDate.day.toString())
              .collection('Fiber')
              .add({'Fiber': fiber, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(sunDate.year.toString())
              .collection('month')
              .doc(sunDate.month.toString())
              .collection('day')
              .doc(sunDate.day.toString())
              .collection('Sugar')
              .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(sunDate.year.toString())
              .collection('month')
              .doc(sunDate.month.toString())
              .collection('day')
              .doc(sunDate.day.toString())
              .collection('Protein')
              .add({'Protein': protein, 'timestamp': DateTime.now()});
        }
        sunCalories.add(calorie);
        break;
    }
  }


  List<int> getDailyCalories() {
    List<int> tempList = [];
    tempList.add(monCalories.fold(0, (total,current) => total + current));
    tempList.add(tueCalories.fold(0, (total,current) => total + current));
    tempList.add(wedCalories.fold(0, (total,current) => total + current));
    tempList.add(thuCalories.fold(0, (total,current) => total + current));
    tempList.add(friCalories.fold(0, (total,current) => total + current));
    tempList.add(satCalories.fold(0, (total,current) => total + current));
    tempList.add(sunCalories.fold(0, (total,current) => total + current));

    return tempList;

  }

}
