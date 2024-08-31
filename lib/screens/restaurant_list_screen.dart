import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/widgets/restaurant_list_view.dart';
import '../controllers/restaurant_list_controller.dart';

class RestaurantListScreen extends ConsumerWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsState = ref.watch(restaurantListControllerProvider);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Restaurants', style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[850],
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search restaurants...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                ref.read(restaurantListControllerProvider.notifier).searchRestaurants(query);
              },
            ),
          ),
          Expanded(
            child: restaurantsState.when(
              data: (restaurants) => RestaurantListView(restaurants: restaurants),
              loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
              error: (error, _) => Center(child: Text('Error: $error', style: const TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}