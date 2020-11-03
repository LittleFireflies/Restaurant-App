import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/entities/menus.dart';

class Restaurant extends Equatable {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.address,
    this.rating,
    this.menus,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  String address;
  double rating;
  Menus menus;
  List<CustomerReview> customerReviews;

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        address: json["address"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromMap(json["menus"]),
        customerReviews: json["customerReviews"] != null
            ? List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "address": address,
        "rating": rating,
        "menus": menus.toMap(),
        "customerReviews":
            List<dynamic>.from(customerReviews.map((e) => e.toMap())),
      };

  @override
  List<Object> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        address,
        rating,
        menus,
        customerReviews,
      ];
}
