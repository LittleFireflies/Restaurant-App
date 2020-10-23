import 'package:restaurant_app/domain/entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<RestaurantResponse> getRestaurantList();
}
