import '../models/nutrition_goal_model.dart';

class NutritionGoalPresenter {
  final NutritionGoalModel _model = NutritionGoalModel();

  String evaluateIntake(String event) {

  final bulkingDifferences = 
    _model.nutrientDifferences(event, NutritionGoalModel.bulkingTarget);
  final cuttingDifferences = 
    _model.nutrientDifferences(event, NutritionGoalModel.cuttingTarget);

  

    // Calculate the total absolute difference for each target to find the closest goal
    double bulkingScore = 
    bulkingDifferences.values.map((d) => d.abs()).reduce((a, b) => a + b);
    double cuttingScore = 
    cuttingDifferences.values.map((d) => d.abs()).reduce((a, b) => a + b);

    final closestGoal = bulkingScore < cuttingScore ? 'bulking' : 'cutting';
    final differences = closestGoal == 'bulking' 
      ? bulkingDifferences 
      : cuttingDifferences;
    final target = closestGoal == 'bulking' 
      ? NutritionGoalModel.bulkingTarget 
      : NutritionGoalModel.cuttingTarget;

    // Classify each nutrient based on its difference from the target
    // final withinTarget = differences.entries
    // .where((entry) => entry.value.abs() <= entry.value * 0.1)
    // .map((e) => e.key)
    // .toList();
    
    // final aboveTarget = differences.entries
    // .where((entry) => entry.value > 0.1 * (closestGoal == 'bulking' ? NutritionGoalModel.bulkingTarget[entry.key]! : NutritionGoalModel.cuttingTarget[entry.key]!))
    // .map((entry) => entry.key)
    // .toList();

    // final belowTarget = differences.entries
    // .where((entry) => entry.value < -0.1 * (closestGoal == 'bulking' ? NutritionGoalModel.bulkingTarget[entry.key]! : NutritionGoalModel.cuttingTarget[entry.key]!))
    // .map((entry) => entry.key)
    // .toList();

    final withinTarget = differences.entries
    .where((entry) => entry.value.abs() <= 0.1 * target[entry.key]!)
    .map((e) => e.key)
    .toList();

    final aboveTarget = differences.entries
    .where((entry) => entry.value > 0)
    .map((entry) => entry.key)
    .toList();

    final belowTarget = differences.entries
    .where((entry) => entry.value < 0)
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

    final caffeineMessage = evaluateCaffeineIntake(event);
      if (caffeineMessage.isNotEmpty) {
        message += '\n$caffeineMessage';
      }
      return message;
    }

  //  String evaluateCaffeineIntake(String eventData) {
  //   final caffeineData = RegExp(r'Caffeine \(mg\): (\d+)').firstMatch(eventData);
  //   if (caffeineData != null) {
  //     final caffeineIntake = int.parse(caffeineData.group(1) ?? '0');
  //     if (caffeineIntake > NutritionGoalModel.caffeineLimit) {
  //       return 'Your caffeine intake is too high (${caffeineIntake}mg). Reduce your caffeine consumption!';
  //     }
  //   }
  //   return 'Your caffeine daily intake looks good!';
  // }
   
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
