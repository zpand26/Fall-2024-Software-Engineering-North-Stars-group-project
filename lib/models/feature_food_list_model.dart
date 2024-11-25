// feature_food_list_model.dart
class FeatureFoodListModel {
  final List<String> allFoods = [
    'Vegan Salad',
    'Chicken Wrap',
    'Vegetarian Pizza',
    'Beef Steak',
    'Fish Tacos',
    'Fruit Smoothie'
  ];
  List<String> filteredFoods = [];
  List<String> favoriteFoods = []; // List to track foods the user likes

  List<String> applyFilters(List<String> selectedFilters) {
    if (selectedFilters.isEmpty) {
      return List.from(allFoods);
    } else {
      return allFoods.where((food) {
        return selectedFilters.any((filter) => food.toLowerCase().contains(filter.toLowerCase()));
      }).toList();
    }
  }
}
