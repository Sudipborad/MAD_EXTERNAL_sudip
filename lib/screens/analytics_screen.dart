import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_colors.dart';
import '../providers/analytics_provider.dart';
import '../widgets/analytics_chart.dart';
import '../providers/goal_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyCals = ref.watch(dailyCaloriesProvider);
    final progress = ref.watch(calorieProgressProvider);
    final weeklyData = ref.watch(weeklyTrendProvider);
    final goal = ref.watch(goalProvider).calorieGoal;
    
    final protein = ref.watch(dailyProteinProvider);
    final carbs = ref.watch(dailyCarbsProvider);
    final fats = ref.watch(dailyFatsProvider);
    
    final totalMacros = protein + carbs + fats;
    final pPct = totalMacros > 0 ? (protein / totalMacros) : 0.0;
    final cPct = totalMacros > 0 ? (carbs / totalMacros) : 0.0;
    final fPct = totalMacros > 0 ? (fats / totalMacros) : 0.0;

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
                padding: const EdgeInsets.fromLTRB(22, 50, 22, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('📈 Analytics', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                    const Text('Your nutrition trends & insights', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _buildTab('Weekly', true),
                        const SizedBox(width: 8),
                        _buildTab('Monthly', false),
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
                  Row(
                    children: [
                      Expanded(child: _buildInsightCard('🔥', '$dailyCals', 'Avg Daily')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildInsightCard('🏆', 'Today', 'Best Day')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildInsightCard('🎯', '${(progress * 100).toStringAsFixed(0)}%', 'Goal Rate')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildChartCard(
                    title: 'Weekly Calorie Trend',
                    child: AnalyticsChart(weeklyData: weeklyData, goal: goal.toDouble()),
                  ),
                  _buildChartCard(
                    title: 'Today\'s Goal Achievement',
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              const CircularProgressIndicator(value: 1.0, strokeWidth: 10, color: Color(0xFFE8F5E9)),
                              CircularProgressIndicator(value: progress, strokeWidth: 10, strokeCap: StrokeCap.round, color: AppColors.primary),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${(progress * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primaryDark)),
                                    const Text('achieved', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCircLegend(AppColors.primary, 'Goals Met', '${(progress * 100).toStringAsFixed(0)}%'),
                              const SizedBox(height: 6),
                              _buildCircLegend(const Color(0xFFEF5350), 'Over Goal', '0%'),
                              const SizedBox(height: 6),
                              _buildCircLegend(const Color(0xFFBDBDBD), 'Under Goal', '${((1 - progress) * 100).toStringAsFixed(0)}%'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildChartCard(
                    title: 'Nutrient Distribution',
                    child: totalMacros == 0 ? const Center(child: Text("No data yet")) : Column(
                      children: [
                        Container(
                          height: 14,
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(99)),
                          clipBehavior: Clip.hardEdge,
                          child: Row(
                            children: [
                              Expanded(flex: (pPct * 100).toInt(), child: Container(color: AppColors.primary)),
                              Expanded(flex: (cPct * 100).toInt(), child: Container(color: const Color(0xFF1976D2))),
                              Expanded(flex: (fPct * 100).toInt(), child: Container(color: const Color(0xFFE65100))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDistLegend(AppColors.primary, 'Protein ${(pPct * 100).toStringAsFixed(0)}%'),
                            _buildDistLegend(const Color(0xFF1976D2), 'Carbs ${(cPct * 100).toStringAsFixed(0)}%'),
                            _buildDistLegend(const Color(0xFFE65100), 'Fat ${(fPct * 100).toStringAsFixed(0)}%'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(color: isActive ? Colors.white : Colors.white24, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: isActive ? AppColors.primaryDark : Colors.white)),
    );
  }

  Widget _buildInsightCard(String icon, String val, String lbl) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(val, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.primaryDark)),
          Text(lbl, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.3)),
        ],
      ),
    );
  }

  Widget _buildChartCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildCircLegend(Color color, String text, String pct) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
        const Spacer(),
        Text(pct, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.black87)),
      ],
    );
  }

  Widget _buildDistLegend(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
      ],
    );
  }
}
