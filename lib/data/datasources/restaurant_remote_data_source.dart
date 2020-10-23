import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantRemoteDataSource {
  Future<RestaurantResponse> getRestaurantList();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final http.Client client;

  RestaurantRemoteDataSourceImpl({@required this.client});

  @override
  Future<RestaurantResponse> getRestaurantList() async {
    final response =
        await client.get('https://restaurant-api.dicoding.dev/list');

    return RestaurantResponse.fromMap(json.decode(response.body));
  }
}
