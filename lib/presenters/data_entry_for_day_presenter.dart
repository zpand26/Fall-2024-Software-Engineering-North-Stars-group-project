import 'package:north_stars/models/data_entry_for_day_model.dart';

class DataEntryForDayPresenter {
  final DataEntryForDayModel dataEntryForDayModel;
  Function(String) updateView;

  DataEntryForDayPresenter(this.dataEntryForDayModel, this.updateView);

  //data fetching
  void loadData() async{
    String data = await dataEntryForDayModel.fetchData();
    updateView(data);
  }

  void addDailyCalorieEntry(int calorie, String day) {
    dataEntryForDayModel.addDailyCalories(calorie, day);
    updateView('Calorie entries added for days.');
  }

//display total calories
  void showDailyCalories() {
    List<int> total = dataEntryForDayModel.getDailyCalories();
    int monTotal = total[0];
    int tueTotal = total[1];
    int wedTotal = total[2];
    int thuTotal = total[3];
    int friTotal = total[4];
    int satTotal = total[5];
    int sunTotal = total[6];
    updateView('Monday: $monTotal, Tuesday: $tueTotal, Wednesday: $wedTotal,'
        ' Thursday: $thuTotal, Friday: $friTotal, Saturday: $satTotal, Sunday: $sunTotal');
  }


//adding calories for day
/*void addCaloriesForDay(int dayCalorie){
      model.addCaloriesForDay(dayCalorie);
      updateView('Day updated. Day: ${model.getSpecificDay()}. Calories: $dayCalorie.');
   }*/

}
