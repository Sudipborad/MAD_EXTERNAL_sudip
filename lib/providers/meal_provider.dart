import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/repositories/hive_repository.dart';
import '../models/meal_entry.dart';

class MealNotifier extends StateNotifier<List<MealEntry>> {
  final HiveRepository _repository;

  MealNotifier(this._repository) : super([]) {
    _loadMeals();
  }

  void _loadMeals() {
    state = _repository.getMeals();
  }

  Future<void> addMeal(MealEntry meal) async {
    await _repository.addMeal(meal);
    state = [...state, meal];
  }

  Future<void> updateMeal(MealEntry updatedMeal) async {
    await _repository.addMeal(updatedMeal);
    state = [
      for (final meal in state)
        if (meal.id == updatedMeal.id) updatedMeal else meal
    ];
  }

  Future<void> deleteMeal(String id) async {
    await _repository.deleteMeal(id);
    state = state.where((meal) => meal.id != id).toList();
  }
}

final hiveRepositoryProvider = Provider<HiveRepository>((ref) {
  return HiveRepository();
});

final mealProvider = StateNotifierProvider<MealNotifier, List<MealEntry>>((ref) {
  final repository = ref.watch(hiveRepositoryProvider);
  return MealNotifier(repository);
});
