import 'package:dartz/dartz.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/repositories/restaurant_repository.dart';

class GetRestaurantList {
  final RestaurantRepository repository;

  GetRestaurantList(this.repository);

  Future<Either<Failure, List<Restaurant>>> execute() async {
    return await repository.getRestaurantList();
  }
}
