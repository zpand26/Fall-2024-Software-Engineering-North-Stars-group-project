class DataEntryForDayModel {
  // Calories for each day of each week
  Map<String, List<int>> weekCalories = {
    'Week 1': [0, 0, 0, 0, 0, 0, 0], // Monday to Sunday
    'Week 2': [0, 0, 0, 0, 0, 0, 0],
    'Week 3': [0, 0, 0, 0, 0, 0, 0],
    'Week 4': [0, 0, 0, 0, 0, 0, 0],
  };

  // Add calories to a specific day in a specific week
  void addDailyCalories(int calorie, String day, String week) {
    int dayIndex = _getDayIndex(day);  // Get the index of the day (Mon = 0, Tue = 1, etc.)
    if (dayIndex != -1 && weekCalories.containsKey(week)) {
      weekCalories[week]?[dayIndex] += calorie;  // Add calories to the specific day in the selected week
    }
  }

  // Get the index of the day (Mon = 0, Tue = 1, etc.)
  int _getDayIndex(String day) {
    switch (day) {
      case "Mon":
        return 0;
      case "Tue":
        return 1;
      case "Wed":
        return 2;
      case "Thu":
        return 3;
      case "Fri":
        return 4;
      case "Sat":
        return 5;
      case "Sun":
        return 6;
      default:
        return -1;
    }
  }

  // Get total calories for each day for the selected week
  List<int> getDailyCalories(String selectedWeek) {
    // Ensure the week exists in the map
    if (weekCalories.containsKey(selectedWeek)) {
      return weekCalories[selectedWeek] ?? [0, 0, 0, 0, 0, 0, 0];
    }
    return [0, 0, 0, 0, 0, 0, 0]; // Return a default list if the week is not found
  }
}
