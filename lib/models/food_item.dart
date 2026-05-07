class FoodItem {
  final String id;
  final String name;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;

  FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  FoodItem copyWith({
    String? id,
    String? name,
    int? calories,
    int? protein,
    int? carbs,
    int? fats,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
    );
  }
}
