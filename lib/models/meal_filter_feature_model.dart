class MealFilterModel {
  List<String> allMeals = ['Vegan Salad', 'Chicken Wrap', 'Vegetarian Pizza', 'Beef Steak'];
  List<String> filteredMeals = [];

  // Method to apply filters
  List<String> applyFilters(List<String> selectedFilters) {
    if (selectedFilters.isEmpty) {
      return List.from(allMeals);
    } else {
      return allMeals.where((meal) {
        return selectedFilters.any((filter) => meal.toLowerCase().contains(filter.toLowerCase()));
      }).toList();
    }
  }
}