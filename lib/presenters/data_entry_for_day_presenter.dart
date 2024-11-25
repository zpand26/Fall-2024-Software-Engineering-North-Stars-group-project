import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DataEntryForDayPresenter {
  final DataEntryForDayModel dataEntryForDayModel;
  Function(String) updateView;


  DataEntryForDayPresenter(this.dataEntryForDayModel, this.updateView);

  //data fetching
  void loadData() async{
    String data = await dataEntryForDayModel.fetchData();
    updateView(data);
  }

  void selectDates(DateTime dat1, DateTime dat2) {
    List<DateTime> dateList = [];
    for(int i=0; i<=dat2.difference(dat1).inDays; i++){
      dateList.add(dat1.add(Duration(days:i)));
    }
    int year = dat1.year;
    int entryMonth = dat1.month;
    dataEntryForDayModel.updateDateList(dateList);

  }

  void addDailyCalorieEntry(int calorie, int Fat, int cholesterol,
      int sodium, int carbs, int fiber, int sugar, int protein, String day) {
    dataEntryForDayModel.addDailyCalories(calorie, Fat, cholesterol, sodium,
        carbs, fiber, sugar, protein, day);
    if (dataEntryForDayModel.dateListStatus()){
      updateView('Entries added for days.');
    }
    else {
      updateView('Select a week.');
    }
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
