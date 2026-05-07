import 'package:flutter/material.dart';

class FoodEntryScreen extends StatelessWidget {
  const FoodEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Entry'),
      ),
      body: const Center(
        child: Text('Food Entry Screen'),
      ),
    );
  }
}
