import 'model.dart';

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
    int total = model.getTotalLiquidCalories();
    updateView('Total Liquid Calories: $total');
  }

  void showTotalSolidCalories(){
    int total = model.getTotalSolidCalories();
    updateView('Total Solid Calories: $total');
  }

  void showTotalLiquidCalories(){
    int total = model.getTotalLiquidCalories();
    updateView('Total Liquid Calories: $total');
  }
}