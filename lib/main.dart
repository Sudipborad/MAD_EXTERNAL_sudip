import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/repositories/hive_repository.dart';
import 'core/theme/app_theme.dart';
import 'models/food_item.dart';
import 'models/meal_entry.dart';
import 'models/nutrition_goal.dart';
import 'providers/nav_provider.dart';
import 'screens/analytics_screen.dart';
import 'screens/food_entry_screen.dart';
import 'screens/meal_planning_screen.dart';
import 'screens/search_filter_screen.dart';
import 'screens/tracking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(FoodItemAdapter());
  Hive.registerAdapter(MealEntryAdapter());
  Hive.registerAdapter(NutritionGoalAdapter());

  // Open Boxes
  await Hive.openBox<MealEntry>(HiveRepository.mealsBoxName);
  await Hive.openBox<NutritionGoal>(HiveRepository.goalBoxName);
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Meal Planner',
      theme: AppTheme.lightTheme,
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  final List<Widget> _screens = const [
    MealPlanningScreen(),
    FoodEntryScreen(),
    TrackingScreen(),
    AnalyticsScreen(),
    SearchFilterScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);
    return Scaffold(
      extendBody: true,
      body: _screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: const Color(0xFFE8F5E9),
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32));
              }
              return const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey);
            }),
            iconTheme: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const IconThemeData(color: Color(0xFF2E7D32), size: 22);
              }
              return const IconThemeData(color: Colors.grey, size: 22);
            }),
          ),
          child: NavigationBar(
            height: 68,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              ref.read(navIndexProvider.notifier).state = index;
            },
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Add Meal'),
              NavigationDestination(icon: Icon(Icons.track_changes_outlined), selectedIcon: Icon(Icons.track_changes), label: 'Track'),
              NavigationDestination(icon: Icon(Icons.analytics_outlined), selectedIcon: Icon(Icons.analytics), label: 'Analytics'),
              NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
            ],
          ),
        ),
      ),
    );
  }
}
