import 'package:flutter/material.dart';

class MealPlanningScreen extends StatelessWidget {
  const MealPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planning'),
      ),
      body: const Center(
        child: Text('Meal Planning Screen'),
      ),
    );
  }
}
