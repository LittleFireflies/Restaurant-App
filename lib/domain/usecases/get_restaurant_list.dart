import 'package:dartz/dartz.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/repositories/RestaurantRepository.dart';

class GetRestaurantList {
  final RestaurantRepository repository;

  GetRestaurantList(this.repository);

  Future<Either<Failure, RestaurantResponse>> execute() async {
    return await repository.getRestaurantList();
  }
}
