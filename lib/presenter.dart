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

  //handle adding calories
  void addCalorieEntry(int calorie){
    model.addCalories(calorie);
    updateView('Calorie entry added. Total: ${model.getTotalCalories()}');
  }

  //display total calories
  void showTotalCalories(){
    int total = model.getTotalCalories();
    updateView('Total Calories: $total');
  }
}