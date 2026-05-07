import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class MealCard extends StatelessWidget {
  final String mealType;
  final String foodName;
  final String quantity;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MealCard({
    super.key,
    required this.mealType,
    required this.foodName,
    required this.quantity,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.onEdit,
    this.onDelete,
  });

  Color _getMealTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'breakfast':
        return const Color(0xFF66BB6A);
      case 'lunch':
        return const Color(0xFF42A5F5);
      case 'dinner':
        return const Color(0xFFEF5350);
      case 'snacks':
      case 'snack':
        return const Color(0xFFFFA726);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: _getMealTypeColor(mealType),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  mealType,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  _buildIconButton(Icons.edit, onEdit),
                  const SizedBox(width: 8),
                  _buildIconButton(Icons.delete, onDelete),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            foodName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            quantity,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildMacroBadge('$calories', 'kcal', AppColors.primaryDark),
              const SizedBox(width: 10),
              _buildMacroBadge('${protein}g', 'Protein', AppColors.primaryDark),
              const SizedBox(width: 10),
              _buildMacroBadge('${carbs}g', 'Carbs', AppColors.primaryDark),
              const SizedBox(width: 10),
              _buildMacroBadge('${fat}g', 'Fat', AppColors.primaryDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 13, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildMacroBadge(String val, String lbl, Color valColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            val,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: valColor,
            ),
          ),
          Text(
            lbl,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
