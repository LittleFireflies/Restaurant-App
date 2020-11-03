import 'package:dartz/dartz.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/repositories/restaurant_repository.dart';

class AddReview {
  final RestaurantRepository repository;

  AddReview(this.repository);

  Future<Either<Failure, String>> execute(CustomerReview review) async {
    return await repository.addReview(review);
  }
}
