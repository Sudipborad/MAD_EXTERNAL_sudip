import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CalorieSummaryCard extends StatelessWidget {
  final int consumed;
  final int goal;
  final int remaining;

  const CalorieSummaryCard({
    super.key,
    required this.consumed,
    required this.goal,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    double progress = consumed / goal;
    if (progress > 1.0) progress = 1.0;
    if (progress.isNaN || progress.isInfinite) progress = 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 8,
                  color: AppColors.primary.withOpacity(0.15),
                ),
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  strokeCap: StrokeCap.round,
                  color: AppColors.primary,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$consumed',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryDark,
                          height: 1,
                        ),
                      ),
                      const Text(
                        'kcal',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Calories",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem('$consumed', 'Consumed', AppColors.primaryDark),
                    Container(width: 1, height: 24, color: Colors.grey.shade300),
                    _buildStatItem('$goal', 'Goal', AppColors.primaryDark),
                    Container(width: 1, height: 24, color: Colors.grey.shade300),
                    _buildStatItem('$remaining', 'Remaining', AppColors.error),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String val, String lbl, Color color) {
    return Column(
      children: [
        Text(
          val,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(
          lbl,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
