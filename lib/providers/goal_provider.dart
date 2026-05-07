import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/repositories/hive_repository.dart';
import '../models/nutrition_goal.dart';
import 'meal_provider.dart';

class GoalNotifier extends StateNotifier<NutritionGoal> {
  final HiveRepository _repository;

  GoalNotifier(this._repository)
      : super(_repository.getGoal() ??
            NutritionGoal(
              calorieGoal: 2000,
              proteinGoal: 120,
              carbsGoal: 250,
              fatsGoal: 60,
            ));

  Future<void> updateGoal(NutritionGoal goal) async {
    await _repository.saveGoal(goal);
    state = goal;
  }
}

final goalProvider = StateNotifierProvider<GoalNotifier, NutritionGoal>((ref) {
  final repository = ref.watch(hiveRepositoryProvider);
  return GoalNotifier(repository);
});
