import 'package:hive/hive.dart';

part 'nutrition_goal.g.dart';

@HiveType(typeId: 2)
class NutritionGoal {
  @HiveField(0)
  final int calorieGoal;

  @HiveField(1)
  final int proteinGoal;

  @HiveField(2)
  final int carbsGoal;

  @HiveField(3)
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
