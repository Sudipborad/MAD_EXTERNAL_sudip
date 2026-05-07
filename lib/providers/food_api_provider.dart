import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/food_item.dart';
import '../services/food_api_service.dart';

final foodApiServiceProvider = Provider<FoodApiService>((ref) {
  return FoodApiService();
});

/// Holds the current live search results from the API.
/// Empty when offline or no query entered.
final apiSearchResultsProvider =
    StateProvider<List<FoodItem>>((ref) => []);

/// Indicates if an API search is in progress.
final isApiSearchingProvider = StateProvider<bool>((ref) => false);
