import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal_entry.dart';
import 'goal_provider.dart';
import 'meal_provider.dart';

final dailyCaloriesProvider = Provider<int>((ref) {
  final meals = ref.watch(mealProvider);
  return meals.fold(0, (sum, meal) => sum + meal.totalCalories);
});

final dailyProteinProvider = Provider<int>((ref) {
  final meals = ref.watch(mealProvider);
  return meals.fold(0, (sum, meal) => sum + meal.protein);
});

final dailyCarbsProvider = Provider<int>((ref) {
  final meals = ref.watch(mealProvider);
  return meals.fold(0, (sum, meal) => sum + meal.carbs);
});

final dailyFatsProvider = Provider<int>((ref) {
  final meals = ref.watch(mealProvider);
  return meals.fold(0, (sum, meal) => sum + meal.fats);
});

final calorieRemainingProvider = Provider<int>((ref) {
  final goal = ref.watch(goalProvider).calorieGoal;
  final consumed = ref.watch(dailyCaloriesProvider);
  final remaining = goal - consumed;
  return remaining > 0 ? remaining : 0;
});

final calorieProgressProvider = Provider<double>((ref) {
  final goal = ref.watch(goalProvider).calorieGoal;
  final consumed = ref.watch(dailyCaloriesProvider);
  if (goal == 0) return 0.0;
  final progress = consumed / goal;
  return progress > 1.0 ? 1.0 : progress;
});

// A dummy weekly data provider for analytics. Real implementation would group by date.
final weeklyTrendProvider = Provider<List<double>>((ref) {
  final current = ref.watch(dailyCaloriesProvider).toDouble();
  return [1500, 1800, 2200, 1600, 1900, 1400, current];
});
