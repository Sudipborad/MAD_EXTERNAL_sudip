import 'package:flutter/material.dart';

class NutrientTile extends StatelessWidget {
  final String icon;
  final String name;
  final int current;
  final int goal;
  final Color progressColor;
  final Color progressColorEnd;

  const NutrientTile({
    super.key,
    required this.icon,
    required this.name,
    required this.current,
    required this.goal,
    required this.progressColor,
    required this.progressColorEnd,
  });

  @override
  Widget build(BuildContext context) {
    double progress = goal > 0 ? current / goal : 0.0;
    if (progress > 1.0) progress = 1.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            name.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Colors.grey,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(99),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [progressColor, progressColorEnd],
                  ),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${current}g',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: progressColorEnd,
            ),
          ),
          Text(
            'Goal: ${goal}g',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
