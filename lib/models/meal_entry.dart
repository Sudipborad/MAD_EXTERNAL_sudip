import 'package:hive/hive.dart';

part 'meal_entry.g.dart';

@HiveType(typeId: 1)
class MealEntry {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String foodId;

  @HiveField(2)
  final String foodName;

  @HiveField(3)
  final String mealType;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final int totalCalories;

  @HiveField(6)
  final int protein;

  @HiveField(7)
  final int carbs;

  @HiveField(8)
  final int fats;

  @HiveField(9)
  final DateTime createdAt;

  MealEntry({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.mealType,
    required this.quantity,
    required this.totalCalories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.createdAt,
  });

  MealEntry copyWith({
    String? id,
    String? foodId,
    String? foodName,
    String? mealType,
    int? quantity,
    int? totalCalories,
    int? protein,
    int? carbs,
    int? fats,
    DateTime? createdAt,
  }) {
    return MealEntry(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
      quantity: quantity ?? this.quantity,
      totalCalories: totalCalories ?? this.totalCalories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
