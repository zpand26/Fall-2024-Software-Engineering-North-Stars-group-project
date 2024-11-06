import '../models/meal_filter_feature_model.dart';

class MealFilterPresenter {
  final MealFilterModel model;
  Function(List<String>)? updateView;

  MealFilterPresenter(this.model);

  void onFiltersSelected(List<String> selectedFilters) {
    List<String> filteredMeals = model.applyFilters(selectedFilters);
    updateView?.call(filteredMeals); // Update the view with the filtered meals
  }
}
