import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/food_item.dart';

class FoodApiService {
  static const String _baseUrl =
      'https://world.openfoodfacts.org/cgi/search.pl';

  /// Searches Open Food Facts API for food items matching [query].
  /// Returns a list of FoodItem objects parsed from the API response.
  /// Falls back to an empty list if the request fails.
  Future<List<FoodItem>> searchFoods(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'search_terms': query,
        'search_simple': '1',
        'action': 'process',
        'json': '1',
        'page_size': '8',
        'fields':
            'id,product_name,nutriments',
      });

      final response = await http.get(uri).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = data['products'] as List<dynamic>? ?? [];

        final results = <FoodItem>[];
        for (final p in products) {
          final name = (p['product_name'] ?? '').toString().trim();
          if (name.isEmpty) continue;

          final nutriments = p['nutriments'] ?? {};
          final calories =
              ((nutriments['energy-kcal_100g'] ?? 0) as num).round();
          final protein =
              ((nutriments['proteins_100g'] ?? 0) as num).round();
          final carbs =
              ((nutriments['carbohydrates_100g'] ?? 0) as num).round();
          final fats = ((nutriments['fat_100g'] ?? 0) as num).round();

          results.add(FoodItem(
            id: 'api_${results.length}',
            name: name,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fats: fats,
          ));
        }
        return results;
      }
    } catch (_) {
      // Network error — return empty, UI will fall back to local DB
    }
    return [];
  }
}
