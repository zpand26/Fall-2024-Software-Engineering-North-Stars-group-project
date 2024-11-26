// models/nutrition_model.dart
class NutritionGoalModel {
  static const bulkingTarget = {
    'Calories': 3000,
    'Total Fat': 80,
    'Cholesterol': 300,
    'Sodium': 2400,
    'Total Carbohydrate': 400,
    'Fiber': 30,
    'Total Sugar': 100,
    'Protein': 150
  };

  static const cuttingTarget = {
    'Calories': 2000,
    'Total Fat': 60,
    'Cholesterol': 200,
    'Sodium': 1800,
    'Total Carbohydrate': 200,
    'Fiber': 25,
    'Total Sugar': 70,
    'Protein': 100
  };

  Map<String, double> nutrientDifferences(String event, Map<String, int> target) {
    final regex = RegExp(r'(\w+): (\d+\.?\d*)');
    final intake = <String, double>{};

    for (final match in regex.allMatches(event)) {
      final nutrient = match.group(1);
      final value = double.parse(match.group(2)!);
      if (nutrient != null) {
        intake[nutrient] = value;
      }
    }

    // Calculate the difference for each nutrient in the target
    return target.map((key, targetValue) {
      final intakeValue = intake[key] ?? 0.0;
      return MapEntry(key, intakeValue - targetValue);
    });
  }

// bool isMeetingGoal(String event, Map<String, int> target) {
//   final regex = RegExp(r'(\w+): (\d+\.?\d*)');
//   final intake = <String, double>{};

//   for (final match in regex.allMatches(event)) {
//     final nutrient = match.group(1);
//     final value = double.parse(match.group(2)!);
//     if (nutrient != null) {
//       intake[nutrient] = value;
//     }
//   }

//   return intake.entries.every((entry) {
//     final targetValue = target[entry.key] ?? double.infinity;
//     return entry.value >= targetValue * 0.9 && entry.value <= targetValue * 1.1;
//   });
// }
}