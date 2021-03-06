import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/exception.dart';
import 'package:restaurant_app/domain/entities/add_review_response.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/entities/restaurant_detail_response.dart';
import 'package:restaurant_app/domain/entities/restaurant_list_response.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantRemoteDataSource {
  Future<RestaurantListResponse> getRestaurantList();
  Future<RestaurantDetailResponse> getRestaurantDetail(String id);
  Future<AddReviewResponse> postReview(CustomerReview review);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final http.Client client;

  RestaurantRemoteDataSourceImpl({@required this.client});

  @override
  Future<RestaurantListResponse> getRestaurantList() async {
    final response =
        await client.get('https://restaurant-api.dicoding.dev/list');

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromMap(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response =
        await client.get('https://restaurant-api.dicoding.dev/detail/$id');

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromMap(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddReviewResponse> postReview(CustomerReview review) async {
    final response = await client.post(
      'https://restaurant-api.dicoding.dev/review',
      headers: {'Content-Type': 'application/json'},
      body: review,
    );

    if (response.statusCode == 200) {
      return AddReviewResponse.fromMap(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
