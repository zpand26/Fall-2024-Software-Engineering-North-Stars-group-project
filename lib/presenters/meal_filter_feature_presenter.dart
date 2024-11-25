import '../models/meal_filter_feature_model.dart';

class MealFilterPresenter {
  final MealFilterModel model;
  List<String> selectedFilters = [];
  Function(List<String>)? updateView;

  MealFilterPresenter(this.model);

  // Toggle a filter on/off and apply the updated filters
  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    List<String> filteredMeals = model.applyFilters(selectedFilters);
    updateView?.call(filteredMeals); // Update the view with the filtered meals
  }
}
