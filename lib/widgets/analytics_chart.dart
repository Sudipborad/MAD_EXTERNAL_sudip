import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class AnalyticsChart extends StatelessWidget {
  final List<double> weeklyData;
  final double goal;

  const AnalyticsChart({
    super.key,
    required this.weeklyData,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.0,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 3000,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1000,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 0: text = const Text('Mon', style: style); break;
                    case 1: text = const Text('Tue', style: style); break;
                    case 2: text = const Text('Wed', style: style); break;
                    case 3: text = const Text('Thu', style: style); break;
                    case 4: text = const Text('Fri', style: style); break;
                    case 5: text = const Text('Sat', style: style); break;
                    case 6: text = const Text('Sun', style: style); break;
                    default: text = const Text('', style: style); break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: text,
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: goal,
                color: AppColors.error,
                strokeWidth: 1.5,
                dashArray: [5, 4],
                label: HorizontalLineLabel(
                  show: true,
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                  labelResolver: (line) => 'Goal',
                ),
              ),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                weeklyData.length,
                (index) => FlSpot(index.toDouble(), weeklyData[index]),
              ),
              isCurved: false,
              color: AppColors.primary,
              barWidth: 2.5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
