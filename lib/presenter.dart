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
