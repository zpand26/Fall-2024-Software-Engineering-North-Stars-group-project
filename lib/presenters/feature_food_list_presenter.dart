// feature_food_list_presenter.dart
import '../models/feature_food_list_model.dart';

class FeatureFoodListPresenter {
  final FeatureFoodListModel model;
  List<String> selectedFilters = []; // Track selected filters
  Function(List<String>)? updateView; // Callback to update the view with filtered foods

  FeatureFoodListPresenter(this.model);

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    applyFilters();
  }

  void applyFilters() {
    List<String> filteredFoods = model.applyFilters(selectedFilters);
    updateView?.call(filteredFoods); // Update the view with the filtered foods
  }

  void toggleFavoriteFood(String food) {
    if (model.favoriteFoods.contains(food)) {
      model.favoriteFoods.remove(food);
    } else {
      model.favoriteFoods.add(food);
    }
  }
}
