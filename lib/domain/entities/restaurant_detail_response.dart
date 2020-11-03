import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';

class RestaurantDetailResponse extends Equatable {
  RestaurantDetailResponse({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory RestaurantDetailResponse.fromMap(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromMap(json["restaurant"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toMap(),
      };

  @override
  List<Object> get props => [error, message, restaurant];
}
