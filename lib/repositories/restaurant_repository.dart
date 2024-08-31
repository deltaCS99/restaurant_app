import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';

class RestaurantRepository {
  Future<List<Restaurant>> loadRestaurants() async {
    final jsonString = await rootBundle.loadString('assets/restaurants.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Restaurant.fromJson(json)).toList();
  }
}

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  return RestaurantRepository();
});

final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  final repository = ref.watch(restaurantRepositoryProvider);
  return repository.loadRestaurants();
});