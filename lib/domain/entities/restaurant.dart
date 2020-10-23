import 'dart:convert';

import 'package:restaurant_app/domain/entities/menus.dart';

RestaurantResponse restaurantResponseFromMap(String str) =>
    RestaurantResponse.fromMap(json.decode(str));

String restaurantResponseToMap(RestaurantResponse data) =>
    json.encode(data.toMap());

class RestaurantResponse {
  RestaurantResponse({
    this.restaurants,
  });

  List<Restaurant> restaurants;

  factory RestaurantResponse.fromMap(Map<String, dynamic> json) =>
      RestaurantResponse(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toMap())),
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromMap(json["menus"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toMap(),
      };
}
