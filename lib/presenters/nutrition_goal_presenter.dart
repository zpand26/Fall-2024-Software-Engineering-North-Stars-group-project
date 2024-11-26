// presenters/calendar_presenter.dart
import '../models/nutrition_goal_model.dart';

class NutritionGoalPresenter {
  final NutritionGoalModel _model = NutritionGoalModel();

  String evaluateIntake(String event) {

    final bulkingDifferences = _model.nutrientDifferences(event, NutritionGoalModel.bulkingTarget);
    final cuttingDifferences = _model.nutrientDifferences(event, NutritionGoalModel.cuttingTarget);

    // Calculate the total absolute difference for each target to find the closest goal
    double bulkingScore = bulkingDifferences.values.map((d) => d.abs()).reduce((a, b) => a + b);
    double cuttingScore = cuttingDifferences.values.map((d) => d.abs()).reduce((a, b) => a + b);

    final closestGoal = bulkingScore < cuttingScore ? 'bulking' : 'cutting';
    final differences = closestGoal == 'bulking' ? bulkingDifferences : cuttingDifferences;

    // Classify each nutrient based on its difference from the target
    final withinTarget = differences.entries.where((entry) => entry.value.abs() <= entry.value * 0.1).map((e) => e.key).toList();
    final aboveTarget = differences.entries
        .where((entry) => entry.value > 0.1 * (closestGoal == 'bulking' ? NutritionGoalModel.bulkingTarget[entry.key]! : NutritionGoalModel.cuttingTarget[entry.key]!))
        .map((entry) => entry.key)
        .toList();

    final belowTarget = differences.entries
        .where((entry) => entry.value < -0.1 * (closestGoal == 'bulking' ? NutritionGoalModel.bulkingTarget[entry.key]! : NutritionGoalModel.cuttingTarget[entry.key]!))
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

    return message;
  }
}