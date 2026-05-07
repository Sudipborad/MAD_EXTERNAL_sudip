class NutritionGoal {
  final int calorieGoal;
  final int proteinGoal;
  final int carbsGoal;
  final int fatsGoal;

  NutritionGoal({
    required this.calorieGoal,
    required this.proteinGoal,
    required this.carbsGoal,
    required this.fatsGoal,
  });

  NutritionGoal copyWith({
    int? calorieGoal,
    int? proteinGoal,
    int? carbsGoal,
    int? fatsGoal,
  }) {
    return NutritionGoal(
      calorieGoal: calorieGoal ?? this.calorieGoal,
      proteinGoal: proteinGoal ?? this.proteinGoal,
      carbsGoal: carbsGoal ?? this.carbsGoal,
      fatsGoal: fatsGoal ?? this.fatsGoal,
    );
  }
}
