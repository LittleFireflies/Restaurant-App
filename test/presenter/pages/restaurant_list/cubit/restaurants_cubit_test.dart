import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_list.dart';
import 'package:restaurant_app/presenter/pages/restaurant_list/cubit/restaurants_cubit.dart';

class MockGetRestaurantList extends Mock implements GetRestaurantList {}

void main() {
  RestaurantsCubit cubit;
  MockGetRestaurantList mockGetRestaurantList;

  setUp(() {
    mockGetRestaurantList = MockGetRestaurantList();

    cubit = RestaurantsCubit(mockGetRestaurantList);
  });

  group('GetRestaurantList', () {
    final testRestaurants = <Restaurant>[];

    test('should get data from the use case', () async {
      // arrange
      when(mockGetRestaurantList.execute())
          .thenAnswer((realInvocation) async => Right(testRestaurants));
      // act
      cubit.getRestaurants();
      // assert
      verify(mockGetRestaurantList.execute());
    });

    blocTest<RestaurantsCubit, RestaurantsState>(
      'should emit [Loading, Loaded] when data is gotten succesfully',
      build: () {
        when(mockGetRestaurantList.execute())
            .thenAnswer((_) async => Right(testRestaurants));
        return cubit;
      },
      act: (cubit) => cubit.getRestaurants(),
      expect: [
        RestaurantsLoading(),
        RestaurantsLoaded(testRestaurants),
      ],
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'should emit [Loading, Error] when unsuccesful',
        build: () {
          when(mockGetRestaurantList.execute())
              .thenAnswer((realInvocation) async => Left(ServerFailure()));
          return cubit;
        },
        act: (context) => cubit.getRestaurants(),
        expect: [
          RestaurantsLoading(),
          RestaurantsError('ServerFailure'),
        ]);
  });
}
