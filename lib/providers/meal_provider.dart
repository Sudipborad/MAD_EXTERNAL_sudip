import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/meal_entry.dart';

class MealNotifier extends StateNotifier<List<MealEntry>> {
  MealNotifier() : super([]);

  void addMeal(MealEntry meal) {
    state = [...state, meal];
  }

  void updateMeal(MealEntry updatedMeal) {
    state = [
      for (final meal in state)
        if (meal.id == updatedMeal.id) updatedMeal else meal
    ];
  }

  void deleteMeal(String id) {
    state = state.where((meal) => meal.id != id).toList();
  }
}

final mealProvider = StateNotifierProvider<MealNotifier, List<MealEntry>>((ref) {
  return MealNotifier();
});
