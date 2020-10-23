import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

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
                final restaurant = restaurants[index];
                return RestaurantItem(restaurant);
              },
            );
          }
        },
      ),
    );
  }
}

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: 'image_${restaurant.name}',
                child: Image.network(
                  restaurant.pictureId,
                  width: 100,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: 20,
                            color: primaryColor,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          restaurant.city,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: primaryColor500),
                        ),
                        SizedBox(width: 8),
                        Text('-'),
                        SizedBox(width: 8),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: primaryColor500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
