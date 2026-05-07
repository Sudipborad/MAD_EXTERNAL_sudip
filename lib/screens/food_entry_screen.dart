import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/calculations.dart';
import '../models/food_item.dart';
import '../models/meal_entry.dart';
import '../providers/food_database_provider.dart';
import '../providers/meal_provider.dart';

class FoodEntryScreen extends ConsumerStatefulWidget {
  const FoodEntryScreen({super.key});

  @override
  ConsumerState<FoodEntryScreen> createState() => _FoodEntryScreenState();
}

class _FoodEntryScreenState extends ConsumerState<FoodEntryScreen> {
  String _mealType = 'Lunch';
  FoodItem? _selectedFood;
  final TextEditingController _quantityController = TextEditingController(text: '100');
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int get _calcCalories => _selectedFood == null
      ? 0
      : Calculations.calculateProportionalValue(_selectedFood!.calories, 100, int.tryParse(_quantityController.text) ?? 0);
  int get _calcProtein => _selectedFood == null
      ? 0
      : Calculations.calculateProportionalValue(_selectedFood!.protein, 100, int.tryParse(_quantityController.text) ?? 0);
  int get _calcCarbs => _selectedFood == null
      ? 0
      : Calculations.calculateProportionalValue(_selectedFood!.carbs, 100, int.tryParse(_quantityController.text) ?? 0);
  int get _calcFats => _selectedFood == null
      ? 0
      : Calculations.calculateProportionalValue(_selectedFood!.fats, 100, int.tryParse(_quantityController.text) ?? 0);

  @override
  Widget build(BuildContext context) {
    final foodDb = ref.watch(foodDatabaseProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 130.0,
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
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Add Meal Entry', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white)),
                        Text('Log what you ate today', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
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
              child: Form(
                key: _formKey,
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
                          Autocomplete<FoodItem>(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) return const Iterable<FoodItem>.empty();
                              return foodDb.where((food) => food.name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                            },
                            displayStringForOption: (FoodItem option) => option.name,
                            onSelected: (FoodItem selection) {
                              setState(() {
                                _selectedFood = selection;
                                _searchController.text = selection.name;
                              });
                            },
                            fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                onEditingComplete: onEditingComplete,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'e.g. Oatmeal, Chicken...',
                                  hintStyle: const TextStyle(color: Colors.black38, fontWeight: FontWeight.w600),
                                  prefixIcon: const Icon(Icons.search, color: Colors.black38, size: 20),
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
                                validator: (val) => _selectedFood == null ? 'Please select a valid food item' : null,
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Quantity'),
                          TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            onChanged: (val) => setState(() {}),
                            validator: (val) {
                              if (val == null || val.isEmpty) return 'Enter quantity';
                              if (int.tryParse(val) == null || int.parse(val) <= 0) return 'Must be > 0';
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(20)),
                                  child: const Text('grams', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                ),
                              ),
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
                          ),
                        ],
                      ),
                    ),
                    _buildFormCard(
                      title: 'Auto-Calculated Calories',
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total Calories', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black54)),
                                Text('Based on ${_quantityController.text.isEmpty ? 0 : _quantityController.text}g',
                                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.grey)),
                              ],
                            ),
                            Text('$_calcCalories kcal', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.primaryDark)),
                          ],
                        ),
                      ),
                    ),
                    _buildFormCard(
                      title: 'Nutritional Preview',
                      child: Row(
                        children: [
                          Expanded(child: _buildMacroPreview('💪', 'Protein', '$_calcProtein', const Color(0xFFC8E6C9))),
                          const SizedBox(width: 10),
                          Expanded(child: _buildMacroPreview('🌾', 'Carbs', '$_calcCarbs', const Color(0xFFBBDEFB))),
                          const SizedBox(width: 10),
                          Expanded(child: _buildMacroPreview('🥑', 'Fat', '$_calcFats', const Color(0xFFFFECB3))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _resetForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F5),
                              foregroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                            ),
                            child: const Text('✕ Clear', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _saveMeal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 4,
                            ),
                            child: const Text('✓ Save Meal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _selectedFood = null;
      _quantityController.text = '100';
    });
  }

  void _saveMeal() {
    if (_formKey.currentState!.validate()) {
      if (_selectedFood == null) return;
      
      final meal = MealEntry(
        id: const Uuid().v4(),
        foodId: _selectedFood!.id,
        foodName: _selectedFood!.name,
        mealType: _mealType,
        quantity: int.parse(_quantityController.text),
        totalCalories: _calcCalories,
        protein: _calcProtein,
        carbs: _calcCarbs,
        fats: _calcFats,
        createdAt: DateTime.now(),
      );

      ref.read(mealProvider.notifier).addMeal(meal);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meal Added Successfully!'), backgroundColor: AppColors.primary),
      );
      
      _resetForm();
    }
  }

  Widget _buildFormCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primaryDark, letterSpacing: 0.5)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black54, letterSpacing: 0.4)),
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
          value: _mealType,
          items: const [
            DropdownMenuItem(value: 'Breakfast', child: Text('🌅 Breakfast', style: TextStyle(fontWeight: FontWeight.bold))),
            DropdownMenuItem(value: 'Lunch', child: Text('☀️ Lunch', style: TextStyle(fontWeight: FontWeight.bold))),
            DropdownMenuItem(value: 'Dinner', child: Text('🌙 Dinner', style: TextStyle(fontWeight: FontWeight.bold))),
            DropdownMenuItem(value: 'Snack', child: Text('🍎 Snack', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          onChanged: (value) {
            if (value != null) setState(() => _mealType = value);
          },
        ),
      ),
    );
  }

  Widget _buildMacroPreview(String emoji, String name, String val, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bgColor.withOpacity(0.4), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(name.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.black54, letterSpacing: 0.3)),
          Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87)),
          const Text('grams', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.black45)),
        ],
      ),
    );
  }
}
