import 'package:north_stars/models/data_entry_for_day_model.dart';

class DataEntryForDayPresenter {
  final DataEntryForDayModel model;
  final Function(String) updateView;

  DataEntryForDayPresenter(this.model, this.updateView);

  void addDailyCalorieEntry(int calorie, String day) {
    model.addDailyCalories(calorie, day);
    updateView('Calorie entries added.');
  }

//display total calories
  void showDailyCalories() {
    List<int> total = model.getDailyCalories();
    updateView('Daily Calories: $total');
  }


  //adding calories for day
  /*void addCaloriesForDay(int dayCalorie){
      model.addCaloriesForDay(dayCalorie);
      updateView('Day updated. Day: ${model.getSpecificDay()}. Calories: $dayCalorie.');
   }*/

}