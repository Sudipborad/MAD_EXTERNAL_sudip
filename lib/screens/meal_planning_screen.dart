import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../widgets/calorie_progress_card.dart';
import '../widgets/meal_card.dart';

class MealPlanningScreen extends StatelessWidget {
  const MealPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Text(
                          'Good Morning 🌿',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          'Alex Johnson',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white24,
                          child: Text('👤', style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Thu, May 7',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
                  const CalorieSummaryCard(
                    consumed: 1450,
                    goal: 2000,
                    remaining: 550,
                  ),
                  _buildSectionHeader('🌅 Breakfast'),
                  const MealCard(
                    mealType: 'Breakfast',
                    foodName: 'Oatmeal with Berries',
                    quantity: '1 bowl (250g)',
                    calories: 320,
                    protein: 8,
                    carbs: 52,
                    fat: 6,
                  ),
                  _buildSectionHeader('☀️ Lunch'),
                  const MealCard(
                    mealType: 'Lunch',
                    foodName: 'Grilled Chicken Salad',
                    quantity: '1 plate (350g)',
                    calories: 480,
                    protein: 38,
                    carbs: 22,
                    fat: 14,
                  ),
                  _buildSectionHeader('🌙 Dinner'),
                  const MealCard(
                    mealType: 'Dinner',
                    foodName: 'Salmon with Veggies',
                    quantity: '1 serving (300g)',
                    calories: 520,
                    protein: 42,
                    carbs: 18,
                    fat: 22,
                  ),
                  _buildSectionHeader('🍎 Snacks'),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: const [
                          Text('🍽️', style: TextStyle(fontSize: 36)),
                          SizedBox(height: 8),
                          Text(
                            'No snacks added yet',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 80), // bottom nav padding
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryDark,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '+ Add',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
