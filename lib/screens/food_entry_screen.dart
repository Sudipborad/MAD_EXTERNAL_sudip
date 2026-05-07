import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class FoodEntryScreen extends StatelessWidget {
  const FoodEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
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
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Add Meal Entry',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Log what you ate today',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
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
                children: [
                  _buildFormCard(
                    title: 'Meal Details',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Meal Type'),
                        _buildDropdown(),
                        const SizedBox(height: 16),
                        _buildLabel('Search Food Item'),
                        _buildTextField(
                          hint: 'e.g. Oatmeal, Chicken, Apple...',
                          icon: Icons.search,
                          initialValue: 'Grilled Chicken Breast',
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Quantity'),
                                  _buildTextField(
                                    initialValue: '150',
                                    suffixText: 'grams',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Servings'),
                                  _buildTextField(
                                    initialValue: '1',
                                    suffixText: '× srv',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildFormCard(
                    title: 'Auto-Calculated Calories',
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Total Calories',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Based on 150g serving',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '248 kcal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildFormCard(
                    title: 'Nutritional Preview',
                    child: Row(
                      children: [
                        Expanded(child: _buildMacroPreview('💪', 'Protein', '31', const Color(0xFFC8E6C9))),
                        const SizedBox(width: 10),
                        Expanded(child: _buildMacroPreview('🌾', 'Carbs', '0', const Color(0xFFBBDEFB))),
                        const SizedBox(width: 10),
                        Expanded(child: _buildMacroPreview('🥑', 'Fat', '5', const Color(0xFFFFECB3))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5F5F5),
                            foregroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                          ),
                          child: const Text('✕ Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                          ),
                          child: const Text('✓ Save Meal', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
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

  Widget _buildFormCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryDark,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Colors.black54,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: 'Lunch',
          items: const [
            DropdownMenuItem(value: 'Breakfast', child: Text('🌅 Breakfast', style: TextStyle(fontWeight: FontWeight.bold))),
            DropdownMenuItem(value: 'Lunch', child: Text('☀️ Lunch', style: TextStyle(fontWeight: FontWeight.bold))),
            DropdownMenuItem(value: 'Dinner', child: Text('🌙 Dinner', style: TextStyle(fontWeight: FontWeight.bold))),
            DropdownMenuItem(value: 'Snack', child: Text('🍎 Snack', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildTextField({String? hint, IconData? icon, String? initialValue, String? suffixText, TextInputType? keyboardType}) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38, fontWeight: FontWeight.w600),
        prefixIcon: icon != null ? Icon(icon, color: Colors.black38, size: 20) : null,
        suffixIcon: suffixText != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    suffixText,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      ),
    );
  }

  Widget _buildMacroPreview(String emoji, String name, String val, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(
            name.toUpperCase(),
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.black54, letterSpacing: 0.3),
          ),
          Text(
            val,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
          ),
          const Text(
            'grams',
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
