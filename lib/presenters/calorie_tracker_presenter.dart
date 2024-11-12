import '../models/calorie_tracker_model.dart';


class CalorieTrackerPresenter {
  final CalorieTrackerModel calorieTrackerModel;
  Function(String) updateView;



  CalorieTrackerPresenter(this.calorieTrackerModel, this.updateView);

  //adding solid calories
  void addSolidCalorieEntry(int calorie) async {
    await calorieTrackerModel.addSolidCalories(calorie);
    int totalSolid = await calorieTrackerModel.getTotalSolidCalories();
    int totalCalories = await calorieTrackerModel.getTotalCalories();
    updateView('Solid calorie entry added. Total: $totalSolid (Solid), $totalCalories (Total)');
  }

  // Add liquid calorie entry
  void addLiquidCalorieEntry(int calorie) async {
    await calorieTrackerModel.addLiquidCalories(calorie);
    int totalLiquid = await calorieTrackerModel.getTotalLiquidCalories();
    int totalCalories = await calorieTrackerModel.getTotalCalories();
    updateView('Liquid calorie entry added. Total: $totalLiquid (Liquid), $totalCalories (Total)');
  }

  //display total liquid calories
  void showTotalLiquidCalories() async {
    int totalLiquid = await calorieTrackerModel.getTotalLiquidCalories();
    updateView('Total Liquid Calories: $totalLiquid');
  }

  void showTotalSolidCalories() async {
    int totalSolid = await calorieTrackerModel.getTotalSolidCalories();
    updateView('Total Solid Calories: $totalSolid');
  }

  void showTotalCalories() async {
    int total = await calorieTrackerModel.getTotalCalories();
    updateView('Total Calories: $total');
  }


}