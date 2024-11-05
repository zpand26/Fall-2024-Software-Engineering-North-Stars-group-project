import '../models/calorie_tracker_model.dart';

<<<<<<< HEAD
class AppPresenter {
  final NutrientTrackingModel model;
=======
class CalorieTrackerPresenter {
  final CalorieTrackerModel calorieTrackerModel;
>>>>>>> 96d115df0c934d5d19942b2b3fd235add9ba9079
  final Function(String) updateView;

  CalorieTrackerPresenter(this.calorieTrackerModel, this.updateView);

  //data fetching
  void loadData() async{
    String data = await calorieTrackerModel.fetchData();
    updateView(data);
  }

  //adding solid calories
  void addSolidCalorieEntry(int calorie){
    calorieTrackerModel.addSolidCalories(calorie);
    updateView('Solid calorie entry added. Total: ${calorieTrackerModel.getTotalSolidCalories()} (Solid), ${calorieTrackerModel.getTotalCalories()} (Total)');
  }

  // Add liquid calorie entry
  void addLiquidCalorieEntry(int calorie) {
    calorieTrackerModel.addLiquidCalories(calorie);
    updateView('Liquid Calorie entry added Total: ${calorieTrackerModel.getTotalLiquidCalories()} (Liquid), ${calorieTrackerModel.getTotalCalories()} (Total)');
  }
  //display total liquid calories
  void showTotalLiquidCalories(){
    int totalLiquid = calorieTrackerModel.getTotalLiquidCalories();
    updateView('Total Liquid Calories: $totalLiquid');
  }

  void showTotalSolidCalories(){
    int totalSolid = calorieTrackerModel.getTotalSolidCalories();
    updateView('Total Solid Calories: $totalSolid');
  }

  void showTotalCalories(){
    int total = calorieTrackerModel.getTotalCalories();
    updateView('Total Calories: $total');
  }


}