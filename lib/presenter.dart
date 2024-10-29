import 'model.dart';

class AppPresenter {
  final AppModel model;
  Function(String)? updateView; // Optional function reference

  AppPresenter(this.model);

  // Add calorie entry and update view
  void addCalorieEntry(int calorie) {
    model.addCalories(calorie);
    int totalCalories = model.getTotalCalories();
    updateView?.call('Calorie added: $calorie. Total: $totalCalories');
  }

  // Remove calorie entry and update view
  void removeCalorieEntry(int calorie) {
    model.removeCalories(calorie);
    int totalCalories = model.getTotalCalories();
    updateView?.call('Calorie removed: $calorie. Total: $totalCalories');
  }

  // Fetch data example
  void loadData() async {
    String data = await model.fetchData();
    updateView?.call(data);
  }
}