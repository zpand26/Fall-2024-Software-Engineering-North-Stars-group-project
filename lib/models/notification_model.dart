class AppModel {
  // Sample method to fetch or process data
  Future<String> fetchData() async {
    // Simulating a data fetch or API call
    await Future.delayed(Duration(seconds: 2));
    return "Hello from Model!";
  }

  List<int> _calories = [];

  // Add calories to the list
  void addCalories(int calorie) {
    _calories.add(calorie);
  }

  // Remove calories entry from the list
  void removeCalories(int calorie) {
    _calories.remove(calorie);
  }

  // Get total calories
  int getTotalCalories() {
    return _calories.fold(0, (total, current) => total + current);
  }

  // Get the list of all calorie entries
  List<int> getAllCalorieEntries() {
    return _calories;
  }
}
