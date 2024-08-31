import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../repositories/restaurant_repository.dart';

class RestaurantListController extends StateNotifier<AsyncValue<List<Restaurant>>> {
  RestaurantListController(this.ref) : super(const AsyncValue.loading()) {
    loadRestaurants();
  }

  final Ref ref;
  List<Restaurant> _allRestaurants = [];

  Future<void> loadRestaurants() async {
    state = const AsyncValue.loading();
    try {
      _allRestaurants = await ref.read(restaurantRepositoryProvider).loadRestaurants();
      state = AsyncValue.data(_allRestaurants);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void searchRestaurants(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allRestaurants);
    } else {
      final filteredRestaurants = _allRestaurants.where((restaurant) =>
          restaurant.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
      state = AsyncValue.data(filteredRestaurants);
    }
  }
}

final restaurantListControllerProvider = StateNotifierProvider<RestaurantListController, AsyncValue<List<Restaurant>>>((ref) {
  return RestaurantListController(ref);
});