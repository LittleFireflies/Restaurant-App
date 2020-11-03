import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_detail.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  GetRestaurantDetail usecase;
  MockRestaurantRepository repository;

  setUp(() {
    repository = MockRestaurantRepository();
    usecase = GetRestaurantDetail(repository);
  });

  final testRestaurantId = '1abc';
  final testRestaurant = Restaurant();

  test('should get restaurant detail from repository when ', () async {
    // arrange
    when(repository.getRestaurantDetail(testRestaurantId))
        .thenAnswer((realInvocation) async => Right(testRestaurant));
    // act
    final result = await usecase.execute(testRestaurantId);
    // assert
    expect(result, Right(testRestaurant));
    verify(repository.getRestaurantDetail(testRestaurantId));
  });
}
