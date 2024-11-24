import 'package:north_stars/models/data_entry_for_day_model.dart';

class DataEntryForDayPresenter {
  final DataEntryForDayModel dataEntryForDayModel;
  Function(String) updateView;

  DataEntryForDayPresenter(this.dataEntryForDayModel, this.updateView);

  // Add daily calorie entry for a specific day and week
  void addDailyCalorieEntry(int calorie, String day, String week) {
    dataEntryForDayModel.addDailyCalories(calorie, day, week);
    updateView('Calorie entries added for $week.');
  }

  // Show daily calories for the selected week
  void showDailyCalories(String selectedWeek) {
    List<int> total = dataEntryForDayModel.getDailyCalories(selectedWeek);
    String weekMessage = "$selectedWeek: ";
    weekMessage += 'Mon: ${total[0]}, Tue: ${total[1]}, Wed: ${total[2]}, '
        'Thu: ${total[3]}, Fri: ${total[4]}, Sat: ${total[5]}, Sun: ${total[6]}';
    updateView(weekMessage);
  }
}
