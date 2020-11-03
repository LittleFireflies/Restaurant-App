import 'package:dartz/dartz.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/repositories/restaurant_repository.dart';

class GetRestaurantDetail {
  final RestaurantRepository repository;

  GetRestaurantDetail(this.repository);

  Future<Either<Failure, Restaurant>> execute(String id) async {
    return await repository.getRestaurantDetail(id);
  }
}
