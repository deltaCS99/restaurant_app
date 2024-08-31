import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantListView extends StatelessWidget {
  final List<Restaurant> restaurants;
  const RestaurantListView({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return restaurants.isEmpty
        ? const Center(child: Text('No restaurants found', style: TextStyle(color: Colors.white)))
        : ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return Card(
          color: Colors.grey[800],
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[700],
              child: Text(
                restaurant.name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              restaurant.name,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(restaurant.cuisine, style: TextStyle(color: Colors.grey[400])),
          ),
        );
      },
    );
  }
}