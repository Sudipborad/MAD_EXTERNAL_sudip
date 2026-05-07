class MealEntry {
  final String id;
  final String foodId;
  final String foodName;
  final String mealType;
  final int quantity;
  final int totalCalories;
  final int protein;
  final int carbs;
  final int fats;
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
