import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      '🔍 Search & Filter',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search food items...',
                                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                              controller: TextEditingController(text: 'chicken'),
                            ),
                          ),
                          const Icon(Icons.close, color: Colors.grey, size: 18),
                        ],
                      ),
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
                  const Text('MEAL TYPE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black54)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildChip('All', false),
                      _buildChip('🌅 Breakfast', true),
                      _buildChip('☀️ Lunch', false),
                      _buildChip('🌙 Dinner', false),
                      _buildChip('🍎 Snacks', false),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('DATE FILTER', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black54)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildDateChip('Today', true, false),
                      _buildDateChip('This Week', false, false),
                      _buildDateChip('📅 Custom', false, true),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('3 results for "chicken"', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 10),
                  _buildResultCard('🍗', 'Grilled Chicken Breast', 'Lunch', 'Today, 1:00 PM', 248, const Color(0xFF42A5F5)),
                  _buildResultCard('🥗', 'Chicken Caesar Salad', 'Breakfast', 'Today, 9:00 AM', 380, const Color(0xFF66BB6A)),
                  _buildResultCard('🍜', 'Chicken Rice Bowl', 'Dinner', 'Yesterday, 7:00 PM', 520, const Color(0xFFEF5350)),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F5E9) : Colors.white,
        border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isActive ? AppColors.primaryDark : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDateChip(String label, bool isActive, bool isDashed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Simple border for Flutter standard
        border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade300, width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: isActive ? AppColors.primaryDark : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildResultCard(String emoji, String food, String type, String date, int cal, Color typeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(14)),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: typeColor, borderRadius: BorderRadius.circular(20)),
                      child: Text(type, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)),
                    ),
                    const SizedBox(width: 6),
                    Text(date, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$cal', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.primaryDark)),
              const Text('kcal', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
