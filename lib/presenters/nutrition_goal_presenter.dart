import '../models/nutrition_goal_model.dart';

class NutritionGoalPresenter {
  final NutritionGoalModel _model = NutritionGoalModel();

  String evaluateIntake(String event) {
    // Calculate nutrient differences for bulking and cutting targets
    final bulkingDifferences =
    _model.nutrientDifferences(event, NutritionGoalModel.bulkingTarget);
    final cuttingDifferences =
    _model.nutrientDifferences(event, NutritionGoalModel.cuttingTarget);

    // Calculate the total absolute difference for each target
    double bulkingScore = bulkingDifferences.values
        .map((d) => d.abs())
        .reduce((a, b) => a + b);
    double cuttingScore = cuttingDifferences.values
        .map((d) => d.abs())
        .reduce((a, b) => a + b);

    // Determine the closest goal
    final closestGoal = bulkingScore < cuttingScore ? 'bulking' : 'cutting';
    final differences = closestGoal == 'bulking'
        ? bulkingDifferences
        : cuttingDifferences;
    final target = closestGoal == 'bulking'
        ? NutritionGoalModel.bulkingTarget
        : NutritionGoalModel.cuttingTarget;

    // Classify nutrients based on differences from the target
    final withinTarget = differences.entries
        .where((entry) => entry.value.abs() <= 0.1 * target[entry.key]!)
        .map((entry) => entry.key)
        .toList();

    final aboveTarget = differences.entries
        .where((entry) => entry.value > 0.1 * target[entry.key]!)
        .map((entry) => entry.key)
        .toList();

    final belowTarget = differences.entries
        .where((entry) => entry.value < -0.1 * target[entry.key]!)
        .map((entry) => entry.key)
        .toList();

    // Generate response based on the classifications
    String message = 'You are closest to meeting your $closestGoal goal.\n';

    if (withinTarget.isNotEmpty) {
      message += 'Nutrients within target: ${withinTarget.join(', ')}.\n';
    }
    if (aboveTarget.isNotEmpty) {
      message += 'Nutrients above target: ${aboveTarget.join(', ')}.\n';
    }
    if (belowTarget.isNotEmpty) {
      message += 'Nutrients below target: ${belowTarget.join(', ')}.\n';
    }

    // Add caffeine evaluation
    final caffeineMessage = evaluateCaffeineIntake(event);
    if (caffeineMessage.isNotEmpty) {
      message += '\n$caffeineMessage';
    }

    return message;
  }

  String evaluateCaffeineIntake(String event) {
    final regex = RegExp(r'Caffeine \(mg\): (\d+)');
    final match = regex.firstMatch(event);

    if (match != null) {
      final caffeineIntake = int.parse(match.group(1)!);
      if (caffeineIntake > NutritionGoalModel.caffeineLimit) {
        return 'Your caffeine intake is too high ($caffeineIntake mg). Reduce your caffeine consumption!';
      }
    }

    return 'Your caffeine daily intake looks good!';
  }
}