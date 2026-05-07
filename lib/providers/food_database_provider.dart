import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/food_item.dart';

final defaultFoodDatabase = [
  FoodItem(id: '1', name: 'Rice (Cooked)', calories: 130, protein: 3, carbs: 28, fats: 0),
  FoodItem(id: '2', name: 'Oats', calories: 389, protein: 17, carbs: 66, fats: 7),
  FoodItem(id: '3', name: 'Banana', calories: 89, protein: 1, carbs: 23, fats: 0),
  FoodItem(id: '4', name: 'Egg (Boiled)', calories: 155, protein: 13, carbs: 1, fats: 11),
  FoodItem(id: '5', name: 'Chicken Breast', calories: 165, protein: 31, carbs: 0, fats: 4),
  FoodItem(id: '6', name: 'Milk (Whole)', calories: 61, protein: 3, carbs: 5, fats: 3),
  FoodItem(id: '7', name: 'Bread (Whole Wheat)', calories: 247, protein: 11, carbs: 41, fats: 3),
  FoodItem(id: '8', name: 'Apple', calories: 52, protein: 0, carbs: 14, fats: 0),
];

class FoodDatabaseNotifier extends StateNotifier<List<FoodItem>> {
  FoodDatabaseNotifier() : super(defaultFoodDatabase);

  void addFood(FoodItem food) {
    state = [...state, food];
  }
}

final foodDatabaseProvider = StateNotifierProvider<FoodDatabaseNotifier, List<FoodItem>>((ref) {
  return FoodDatabaseNotifier();
});
