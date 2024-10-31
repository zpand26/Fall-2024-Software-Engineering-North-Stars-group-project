import '../models/model.dart';

class AppPresenter {
  final AppModel model;
  final Function(String) updateView;

  AppPresenter(this.model, this.updateView);

  //data fetching
  void loadData() async{
    String data = await model.fetchData();
    updateView(data);
  }

  //adding solid calories
  void addSolidCalorieEntry(int calorie){
    model.addSolidCalories(calorie);
    updateView('Solid calorie entry added. Total: ${model.getTotalSolidCalories()} (Solid), ${model.getTotalCalories()} (Total)');
  }

  // Add liquid calorie entry
  void addLiquidCalorieEntry(int calorie) {
    model.addLiquidCalories(calorie);
    updateView('Liquid Calorie entry added Total: ${model.getTotalLiquidCalories()} (Liquid), ${model.getTotalCalories()} (Total)');
  }
  //display total liquid calories
  void showTotalLiquidCalories(){
    int totalLiquid = model.getTotalLiquidCalories();
    updateView('Total Liquid Calories: $totalLiquid');
  }

  void showTotalSolidCalories(){
    int totalSolid = model.getTotalSolidCalories();
    updateView('Total Solid Calories: $totalSolid');
  }

  void showTotalCalories(){
    int total = model.getTotalCalories();
    updateView('Total Calories: $total');
  }

  void addDailyCalorieEntry(int calorie, String day){
    model.addDailyCalories(calorie, day);
    updateView('Calorie entries added.');
  }

  //display total calories
  void showDailyCalories(){
    List<int> total = model.getDailyCalories();
    updateView('Daily Calories: $total');
  }


//adding calories for day
/*void addCaloriesForDay(int dayCalorie){
    model.addCaloriesForDay(dayCalorie);
    updateView('Day updated. Day: ${model.getSpecificDay()}. Calories: $dayCalorie.');
  }*/



}