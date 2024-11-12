
import 'package:cloud_firestore/cloud_firestore.dart';

class CalorieTrackerModel {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //add solid calories to firebase
  Future<void> addSolidCalories(int calorie) async{
    await _firestore.collection('solidCalories').add({'calorie': calorie, 'timestamp': DateTime.now()});
  }

  //add liquid calories to firebase
  Future<void> addLiquidCalories(int calorie) async{
    await _firestore.collection('liquidCalories').add({'calorie': calorie, 'timestamp': DateTime.now()});
  }

  //get total solid calories
  Future<int> getTotalSolidCalories() async {
    final querySnapshot = await _firestore.collection('solidCalories').get();
    return querySnapshot.docs.fold<int>(0, (int total, doc) => total + (doc['calorie'] as int));
  }

  //get total liquid calories
  Future<int> getTotalLiquidCalories() async {
    final querySnapshot = await _firestore.collection('liquidCalories').get();
    return querySnapshot.docs.fold<int>(0, (int total, doc) => total + (doc['calorie'] as int));
  }

  //get the total calorie count
  Future<int> getTotalCalories() async {
    int totalLiquid = await getTotalLiquidCalories();
    int totalSolid = await getTotalSolidCalories();
    return totalLiquid + totalSolid;
  }

}