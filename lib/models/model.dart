import 'dart:collection';
import 'data_entry_for_day.model.dart';

class AppModel {
  //sample method to fetch or proccess data
  Future<String> fetchData() async {
    //simulating a data fetch or api call
    await Future.delayed(Duration(seconds: 2));
    return "Hello from Model!";

  }

  final dayData = dataEntryForDayModel();

  List<int> _solidCalories = [];
  List<int> _liquidCalories = [];

  //add solid calories to the list
  void addSolidCalories(int calorie){
    _solidCalories.add(calorie);
  }

  //add liquid calories to the list
  void addLiquidCalories(int calorie){
    _liquidCalories.add(calorie);
  }

  //get total solid calories
  int getTotalSolidCalories(){
    return _solidCalories.fold(0, (total,current) => total + current);
  }

  //get total liquid calories
  int getTotalLiquidCalories(){
    return _liquidCalories.fold(0, (total,current) => total + current);
  }

  //get the total calorie count
  int getTotalCalories(){
    return (getTotalLiquidCalories() + getTotalSolidCalories());
  }

  void addDailyCalories(int calorie, String day){
    dayData.addDailyCalories(calorie, day);
  }

  List<int> getDailyCalories (){
    return dayData.getDailyCalories();
  }

  //get the list of all calorie entries
  /*List<int> getAllCalorieEntries(){
    return _calories;
  }*/

/* List<int> _monCalories = [];
  List<int> _tueCalories = [];
  List<int> _wedCalories = [];
  List<int> _thuCalories = [];
  List<int> _friCalories = [];
  List<int> _satCalories = [];
  List<int> _sunCalories = [];


  void addCaloriesForDay(String day, int dayCalorie) {
    switch (day) {
      case
  }


  getSpecificDay() {} */


}