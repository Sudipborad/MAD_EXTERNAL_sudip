import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_colors.dart';
import '../models/meal_entry.dart';
import '../providers/analytics_provider.dart';
import '../providers/goal_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/nav_provider.dart';
import '../services/sync_service.dart';
import '../widgets/calorie_progress_card.dart';
import '../widgets/meal_card.dart';

class MealPlanningScreen extends ConsumerWidget {
  const MealPlanningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consumed = ref.watch(dailyCaloriesProvider);
    final goal = ref.watch(goalProvider).calorieGoal;
    final remaining = ref.watch(calorieRemainingProvider);
    final meals = ref.watch(mealProvider);

    final breakfast = meals.where((m) => m.mealType == 'Breakfast').toList();
    final lunch = meals.where((m) => m.mealType == 'Lunch').toList();
    final dinner = meals.where((m) => m.mealType == 'Dinner').toList();
    final snacks = meals.where((m) => m.mealType == 'Snack').toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
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
                padding: const EdgeInsets.fromLTRB(22, 60, 22, 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Good Morning 🌿', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white70)),
                        Text('Alex Johnson', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => _handleSync(context, ref),
                          child: const CircleAvatar(radius: 20, backgroundColor: Colors.white24, child: Icon(Icons.sync, color: Colors.white, size: 20)),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                          child: const Text('Thu, May 7', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ),
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
                  CalorieSummaryCard(consumed: consumed, goal: goal, remaining: remaining),
                  _buildSectionHeader('🌅 Breakfast', () => _navToAddMeal(ref)),
                  _buildMealList(context, breakfast, ref),
                  _buildSectionHeader('☀️ Lunch', () => _navToAddMeal(ref)),
                  _buildMealList(context, lunch, ref),
                  _buildSectionHeader('🌙 Dinner', () => _navToAddMeal(ref)),
                  _buildMealList(context, dinner, ref),
                  _buildSectionHeader('🍎 Snacks', () => _navToAddMeal(ref)),
                  _buildMealList(context, snacks, ref),
                  const SizedBox(height: 80), // bottom nav padding
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navToAddMeal(ref),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _navToAddMeal(WidgetRef ref) {
    ref.read(navIndexProvider.notifier).state = 1;
  }

  Future<void> _handleSync(BuildContext context, WidgetRef ref) async {
    final isSyncing = ref.read(isSyncingProvider);
    if (isSyncing) return;

    ref.read(isSyncingProvider.notifier).state = true;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Row(children: [CircularProgressIndicator(strokeWidth: 2, color: Colors.white), SizedBox(width: 10), Text('Syncing with cloud...')]), duration: Duration(seconds: 2)),
    );

    await ref.read(syncServiceProvider).syncData();
    ref.read(isSyncingProvider.notifier).state = false;

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync complete! All offline data is safe.'), backgroundColor: AppColors.primary),
      );
    }
  }

  Widget _buildSectionHeader(String title, VoidCallback onAdd) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
          InkWell(
            onTap: onAdd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(20)),
              child: const Text('+ Add', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealList(BuildContext context, List<MealEntry> meals, WidgetRef ref) {
    if (meals.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: const [
              Text('🍽️', style: TextStyle(fontSize: 36)),
              SizedBox(height: 8),
              Text('No meals added yet', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
            ],
          ),
        ),
      );
    }
    return Column(
      children: meals.map((meal) {
        return MealCard(
          mealType: meal.mealType,
          foodName: meal.foodName,
          quantity: '${meal.quantity}g',
          calories: meal.totalCalories,
          protein: meal.protein,
          carbs: meal.carbs,
          fat: meal.fats,
          onDelete: () {
            ref.read(mealProvider.notifier).deleteMeal(meal.id);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Meal deleted!')));
          },
        );
      }).toList(),
    );
  }
}
