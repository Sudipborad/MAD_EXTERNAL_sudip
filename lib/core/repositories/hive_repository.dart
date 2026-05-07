import 'package:hive_flutter/hive_flutter.dart';

import '../../models/meal_entry.dart';
import '../../models/nutrition_goal.dart';

class HiveRepository {
  static const String mealsBoxName = 'mealsBox';
  static const String goalBoxName = 'goalBox';

  final Box<MealEntry> _mealsBox = Hive.box<MealEntry>(mealsBoxName);
  final Box<NutritionGoal> _goalBox = Hive.box<NutritionGoal>(goalBoxName);

  // --- Meals ---
  List<MealEntry> getMeals() {
    return _mealsBox.values.toList();
  }

  Future<void> addMeal(MealEntry meal) async {
    await _mealsBox.put(meal.id, meal);
  }

  Future<void> deleteMeal(String id) async {
    await _mealsBox.delete(id);
  }

  // --- Goal ---
  NutritionGoal? getGoal() {
    return _goalBox.get('currentGoal');
  }

  Future<void> saveGoal(NutritionGoal goal) async {
    await _goalBox.put('currentGoal', goal);
  }
}
