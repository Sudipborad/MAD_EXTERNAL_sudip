import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_colors.dart';
import '../providers/analytics_provider.dart';
import '../providers/goal_provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/nutrient_tile.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goal = ref.watch(goalProvider);
    final consumed = ref.watch(dailyCaloriesProvider);
    final remaining = ref.watch(calorieRemainingProvider);
    final protein = ref.watch(dailyProteinProvider);
    final carbs = ref.watch(dailyCarbsProvider);
    final fats = ref.watch(dailyFatsProvider);
    final progress = ref.watch(calorieProgressProvider);
    final meals = ref.watch(mealProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(22, 60, 22, 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('📊 Daily Tracking', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                    Text('Thursday, May 7, 2026', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBigSummaryCard(consumed, goal.calorieGoal, remaining, progress),
                  const SizedBox(height: 16),
                  const Text('Nutrient Breakdown', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: NutrientTile(
                          icon: '💪',
                          name: 'Protein',
                          current: protein,
                          goal: goal.proteinGoal,
                          progressColor: const Color(0xFF66BB6A),
                          progressColorEnd: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: NutrientTile(
                          icon: '🌾',
                          name: 'Carbs',
                          current: carbs,
                          goal: goal.carbsGoal,
                          progressColor: const Color(0xFF64B5F6),
                          progressColorEnd: const Color(0xFF1976D2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: NutrientTile(
                          icon: '🥑',
                          name: 'Fats',
                          current: fats,
                          goal: goal.fatsGoal,
                          progressColor: const Color(0xFFFFB74D),
                          progressColorEnd: const Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Meal Timeline', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                  const SizedBox(height: 10),
                  _buildTimeline(meals),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigSummaryCard(int consumed, int goal, int remaining, double progress) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBigStat('$consumed', 'Consumed', AppColors.primary),
              Container(width: 1, height: 50, color: Colors.grey.shade200),
              _buildBigStat('$goal', 'Daily Goal', const Color(0xFF42A5F5)),
              Container(width: 1, height: 50, color: Colors.grey.shade200),
              _buildBigStat('$remaining', 'Remaining', const Color(0xFFFF7043)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Goal Achievement', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
              Text('${(progress * 100).toStringAsFixed(1)}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            height: 10,
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(99)),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF66BB6A), AppColors.primaryDark]),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigStat(String val, String lbl, Color color) {
    return Column(
      children: [
        Text(val, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: color)),
        Text(lbl, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black45)),
      ],
    );
  }

  Widget _buildTimeline(List<dynamic> meals) {
    if (meals.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(30),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 20, offset: const Offset(0, 4))],
        ),
        child: const Center(child: Text('No meals tracked today yet', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
      );
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: meals.asMap().entries.map((entry) {
          final index = entry.key;
          final meal = entry.value;
          final isLast = index == meals.length - 1;
          return _buildTimelineItem(
            meal.foodName,
            '${meal.mealType} · ${meal.quantity}g',
            '${meal.totalCalories}',
            _getColorForType(meal.mealType),
            isLast,
          );
        }).toList(),
      ),
    );
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'breakfast': return const Color(0xFF66BB6A);
      case 'lunch': return const Color(0xFF42A5F5);
      case 'dinner': return const Color(0xFFEF5350);
      case 'snack': return const Color(0xFFFFA726);
      default: return AppColors.primary;
    }
  }

  Widget _buildTimelineItem(String food, String meta, String cal, Color dotColor, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            if (!isLast)
              Container(width: 2, height: 40, color: Colors.grey.shade200, margin: const EdgeInsets.symmetric(vertical: 4)),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(food, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87)),
              const SizedBox(height: 2),
              Text(meta, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black45)),
              if (!isLast) const SizedBox(height: 16),
            ],
          ),
        ),
        Text('$cal kcal', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: dotColor)),
      ],
    );
  }
}
