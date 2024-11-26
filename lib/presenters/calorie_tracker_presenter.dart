import '../models/calorie_tracker_model.dart';

class CalorieTrackerPresenter {
  final CalorieTrackerModel calorieTrackerModel;
  final Function(String) updateView;

  CalorieTrackerPresenter(this.calorieTrackerModel, this.updateView);

  // Add calorie entry
  void addCalorieEntry(int calorie, int year, int month, int day) async {
    await calorieTrackerModel.addCalories(calorie, year, month, day);
    int totalCalories = await calorieTrackerModel.getTotalCaloriesOnDay(year, month, day);
    updateView('Calorie entry added. Total Calories for the day: $totalCalories');
  }

  // Add fat entry
  void addFatEntry(int fat, int year, int month, int day) async {
    await calorieTrackerModel.addFat(fat, year, month, day);
    int totalFat = await calorieTrackerModel.getTotalFatOnDay(year, month, day);
    updateView('Fat entry added. Total Fat for the day: $totalFat');
  }
  // Add ccholesterol entry
  void addCholesterolEntry(int cholesterol, int year, int month, int day) async {
    await calorieTrackerModel.addCholesterol(cholesterol, year, month, day);
    int totalCholesterol = await calorieTrackerModel.getTotalCholesterolOnDay(year, month, day);
    updateView('Cholesterol entry added. Total Cholesterol for the day: $totalCholesterol');
  }
  // Add Sodium entry
  void addSodiumEntry(int sodium, int year, int month, int day) async {
    await calorieTrackerModel.addSodium(sodium, year, month, day);
    int totalSodium = await calorieTrackerModel.getTotalSodiumOnDay(year, month, day);
    updateView('Sodium entry added. Total Sodium for the day: $totalSodium');
  }
  // Add carbs entry
  void addCarbsEntry(int carbs, int year, int month, int day) async {
    await calorieTrackerModel.addCarbs(carbs, year, month, day);
    int totalCarbs = await calorieTrackerModel.getTotalCarbsOnDay(year, month, day);
    updateView('Carbs entry added. Total Carbs for the day: $totalCarbs');
  }
  // Add fiber entry
  void addFiberEntry(int fiber, int year, int month, int day) async {
    await calorieTrackerModel.addFiber(fiber, year, month, day);
    int totalFiber = await calorieTrackerModel.getTotalFiberOnDay(year, month, day);
    updateView('Fiber entry added. Total Fiber for the day: $totalFiber');
  }
  // Add sugar entry
  void addSugarEntry(int sugar, int year, int month, int day) async {
    await calorieTrackerModel.addSugar(sugar, year, month, day);
    int totalSugar = await calorieTrackerModel.getTotalSugarOnDay(year, month, day);
    updateView('Sugar entry added. Total Sugar for the day: $totalSugar');
  }
  // Add protein entry
  void addProteinEntry(int protein, int year, int month, int day) async {
    await calorieTrackerModel.addProtein(protein, year, month, day);
    int totalProtein = await calorieTrackerModel.getTotalProteinOnDay(year, month, day);
    updateView('Protein entry added. Total Protein for the day: $totalProtein');
  }

  // Display total calories for a specific day
  void showTotalCaloriesForDay(int year, int month, int day) async {
    int totalCalories = await calorieTrackerModel.getTotalCaloriesOnDay(year, month, day);
    updateView('Total Calories for the day: $totalCalories');
  }

  // Display total fat for a specific day
  void showTotalFatForDay(int year, int month, int day) async {
    int totalFat = await calorieTrackerModel.getTotalFatOnDay(year, month, day);
    updateView('Total Fat for the day: $totalFat');
  }

  // Display total cholesterol for a specific day
  void showTotalCholesterolForDay(int year, int month, int day) async {
    int totalCholesterol = await calorieTrackerModel.getTotalCholesterolOnDay(year, month, day);
    updateView('Total Cholesterol for the day: $totalCholesterol');
  }

  // Display total sodium for a specific day
  void showTotalSodiumForDay(int year, int month, int day) async {
    int totalSodium = await calorieTrackerModel.getTotalSodiumOnDay(year, month, day);
    updateView('Total Sodium for the day: $totalSodium');
  }

  // Display total carbohydrates for a specific day
  void showTotalCarbsForDay(int year, int month, int day) async {
    int totalCarbs = await calorieTrackerModel.getTotalCarbsOnDay(year, month, day);
    updateView('Total Carbohydrates for the day: $totalCarbs');
  }

  // Display total fiber for a specific day
  void showTotalFiberForDay(int year, int month, int day) async {
    int totalFiber = await calorieTrackerModel.getTotalFiberOnDay(year, month, day);
    updateView('Total Fiber for the day: $totalFiber');
  }

  // Display total sugar for a specific day
  void showTotalSugarForDay(int year, int month, int day) async {
    int totalSugar = await calorieTrackerModel.getTotalSugarOnDay(year, month, day);
    updateView('Total Sugar for the day: $totalSugar');
  }

  // Display total protein for a specific day
  void showTotalProteinForDay(int year, int month, int day) async {
    int totalProtein = await calorieTrackerModel.getTotalProteinOnDay(year, month, day);
    updateView('Total Protein for the day: $totalProtein');
  }
}