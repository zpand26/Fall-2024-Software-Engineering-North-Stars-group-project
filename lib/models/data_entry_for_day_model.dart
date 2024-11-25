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

  List<int> monCalories = [];
  List<int> tueCalories = [];
  List<int> wedCalories = [];
  List<int> thuCalories = [];
  List<int> friCalories = [];
  List<int> satCalories = [];
  List<int> sunCalories = [];

  void updateDateList(List<DateTime> updatedDateList){
    dateList = updatedDateList;
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
              .doc(dateList[0].year.toString())
              .collection('month')
              .doc(dateList[0].month.toString())
              .collection('day')
              .doc(dateList[0].day.toString())
              .collection('Calories')
              .add({'calorie': calorie, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(dateList[0].year.toString())
              .collection('month')
              .doc(dateList[0].month.toString())
              .collection('day')
              .doc(dateList[0].day.toString())
              .collection('Fat')
              .add({'Total Fat': Fat, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(dateList[0].year.toString())
              .collection('month')
              .doc(dateList[0].month.toString())
              .collection('day')
              .doc(dateList[0].day.toString())
              .collection('Cholesterol')
              .add({'Cholesterol': cholesterol, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(dateList[0].year.toString())
              .collection('month')
              .doc(dateList[0].month.toString())
              .collection('day')
              .doc(dateList[0].day.toString())
              .collection('Sodium')
              .add({'Sodium': sodium, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(dateList[0].year.toString())
              .collection('month')
              .doc(dateList[0].month.toString())
              .collection('day')
              .doc(dateList[0].day.toString())
              .collection('Carbohydrates')
              .add({'Total Carbohydrates': carbs, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(dateList[0].year.toString())
              .collection('month')
              .doc(dateList[0].month.toString())
              .collection('day')
              .doc(dateList[0].day.toString())
              .collection('Fiber')
              .add({'Fiber': fiber, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(dateList[0].year.toString())
              .collection('month')
              .doc(dateList[0].month.toString())
              .collection('day')
              .doc(dateList[0].day.toString())
              .collection('Sugar')
              .add({'Total Sugar': sugar, 'timestamp': DateTime.now()});
        }
        if (userId.isNotEmpty) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('year')
              .doc(dateList[0].year.toString())
              .collection('month')
              .doc(dateList[0].month.toString())
              .collection('day')
              .doc(dateList[0].day.toString())
              .collection('Protein')
              .add({'Protein': protein, 'timestamp': DateTime.now()});
        }

        monCalories.add(calorie);
      case 'tue':
        tueCalories.add(calorie);
      case 'wed':
        wedCalories.add(calorie);
      case 'thu':
        thuCalories.add(calorie);
      case 'fri':
        friCalories.add(calorie);
      case 'sat':
        satCalories.add(calorie);
      case 'sun':
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
