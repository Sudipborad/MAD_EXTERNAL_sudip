import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal_entry.dart';
import 'meal_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final searchMealTypeProvider = StateProvider<String>((ref) => 'All');

final filteredMealsProvider = Provider<List<MealEntry>>((ref) {
  final meals = ref.watch(mealProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final typeFilter = ref.watch(searchMealTypeProvider);

  return meals.where((meal) {
    final matchesQuery = query.isEmpty || meal.foodName.toLowerCase().contains(query);
    final matchesType = typeFilter == 'All' || meal.mealType == typeFilter;
    return matchesQuery && matchesType;
  }).toList();
});
