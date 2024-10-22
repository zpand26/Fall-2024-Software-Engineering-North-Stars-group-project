class AppModel {
  //sample method to fetch or proccess data
  Future<String> fetchData() async {
    //simulating a data fetch or api call
    await Future.delayed(Duration(seconds: 2));
    return "Hello from Model!";

  }

  List<int> _calories = [];

  //add calories to the list
  void addCalories(int calorie){
    _calories.add(calorie);
  }
  // Remove calories entry from the list
  void removeCalories(int calorie) {
    _calories.remove(calorie);

  }
  //get total calories
  int getTotalCalories(){
    return _calories.fold(0, (total,current) => total + current);
  }

  //get the list of all calorie entries
  List<int> getAllCalorieEntries(){
    return _calories;
  }

}