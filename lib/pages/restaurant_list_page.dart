import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant List'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final json = jsonDecode(snapshot.data);
            final restaurantResponse = RestaurantResponse.fromMap(json);
            final restaurants = restaurantResponse.restaurants;

            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(restaurants[index].name),
                );
              },
            );
          }
        },
      ),
    );
  }
}
