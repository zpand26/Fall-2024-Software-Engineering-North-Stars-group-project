// presenters/calendar_presenter.dart
import '../models/nutrition_goal_model.dart';

class NutritionGoalPresenter {
  final NutritionGoalModel _model = NutritionGoalModel();

  String evaluateIntake(String event) {
  //   var offTargetNutrients = <String>[];
    
  //   if (_model.isMeetingGoal(event, NutritionGoalModel.bulkingTarget)) {
  //     return 'You are meeting your bulking goals!';
  //   } else if (_model.isMeetingGoal(event, NutritionGoalModel.cuttingTarget)) {
  //     return 'You are meeting your cutting goals!';
  //   } else {
  //     final regex = RegExp(r'(\w+): (\d+\.?\d*)');
  //     final intake = <String, double>{};

  //     for (final match in regex.allMatches(event)) {
  //       final nutrient = match.group(1);
  //       final value = double.parse(match.group(2)!);
  //       if (nutrient != null) {
  //         intake[nutrient] = value;
  //       }
  //     }

  //     for (final entry in intake.entries) {
  //       final bulkingTargetValue = NutritionGoalModel.bulkingTarget[entry.key] ?? double.infinity;
  //       final cuttingTargetValue = NutritionGoalModel.cuttingTarget[entry.key] ?? double.infinity;
        
  //       if (!(entry.value >= bulkingTargetValue * 0.9 && entry.value <= bulkingTargetValue * 1.1) &&
  //           !(entry.value >= cuttingTargetValue * 0.9 && entry.value <= cuttingTargetValue * 1.1)) {
  //         offTargetNutrients.add(entry.key);
  //       }
  //     }

  //     return 'You are not currently on track with either bulking or cutting goals for the following nutrients: ${offTargetNutrients.join(', ')}.';
  //   }
  // }

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

    // Generate a response based on the classifications
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
