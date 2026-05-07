import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/nutrition_goal.dart';

class GoalNotifier extends StateNotifier<NutritionGoal> {
  GoalNotifier()
      : super(NutritionGoal(
          calorieGoal: 2000,
          proteinGoal: 120,
          carbsGoal: 250,
          fatsGoal: 60,
        ));

  void updateGoal(NutritionGoal goal) {
    state = goal;
  }
}

final goalProvider = StateNotifierProvider<GoalNotifier, NutritionGoal>((ref) {
  return GoalNotifier();
});
