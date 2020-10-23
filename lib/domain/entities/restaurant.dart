import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entities/menus.dart';

class RestaurantResponse extends Equatable {
  RestaurantResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory RestaurantResponse.fromMap(Map<String, dynamic> json) =>
      RestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toMap())),
      };

  @override
  List<Object> get props => [error, message, count, restaurants];
}

class Restaurant extends Equatable {
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

  @override
  List<Object> get props =>
      [id, name, description, pictureId, city, rating, menus];
}
