import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/repositories/RestaurantRepository.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_list.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  GetRestaurantList usecase;
  MockRestaurantRepository repository;

  setUp(() {
    repository = MockRestaurantRepository();
    usecase = GetRestaurantList(repository);
  });

  final testRestaurants = RestaurantResponse(restaurants: []);

  test('should get restaurant list from repository', () async {
    // arrange
    when(repository.getRestaurantList())
        .thenAnswer((realInvocation) async => Right(testRestaurants));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(testRestaurants));
    verify(repository.getRestaurantList());
    verifyNoMoreInteractions(repository);
  });
}
