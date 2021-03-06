import 'package:dartz/dartz.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurantList();
  Future<Either<Failure, Restaurant>> getRestaurantDetail(String id);
  Future<Either<Failure, String>> addReview(CustomerReview review);
}
