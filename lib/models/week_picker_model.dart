class WeekModel {
  // Method to calculate the start of the week (Sunday)
  DateTime getStartOfWeek(DateTime date) {
    int daysToSubtract = date.weekday % 7;
    return date.subtract(Duration(days: daysToSubtract));
  }

  // Method to generate a list of dates from Sunday to Saturday for a given week
  List<DateTime> getWeekDays(DateTime selectedDate) {
    DateTime startOfWeek = getStartOfWeek(selectedDate);
    return List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }
}
