
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalorieTrackerModel {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get current users ID
  String get userId => _auth.currentUser?.uid ?? '';


  //add solid calories to firebase
  Future<void> addSolidCalories(int calorie) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('solidCalories')
          .add({'calorie': calorie, 'timestamp': DateTime.now()});
    }
  }

  //add liquid calories to firebase
  Future<void> addLiquidCalories(int calorie) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)  
          .collection('liquidCalories')
          .add({'calorie': calorie, 'timestamp': DateTime.now()});
    }
  }
  //get total solid calories
  Future<int> getTotalSolidCalories() async {
    if (userId.isEmpty) return 0;

    final querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('solidCalories')
        .get();
    return querySnapshot.docs.fold<int>(
        0, (total, doc) => total + (doc['calorie'] as int));
  }

  //get total liquid calories
  Future<int> getTotalLiquidCalories() async {
    if (userId.isEmpty) return 0;

    final querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('liquidCalories')
        .get();
    return querySnapshot.docs.fold<int>(
        0, (total, doc) => total + (doc['calorie'] as int));
  }

  //get the total calorie count
  Future<int> getTotalCalories() async {
    int totalLiquid = await getTotalLiquidCalories();
    int totalSolid = await getTotalSolidCalories();
    return totalLiquid + totalSolid;
  }
}