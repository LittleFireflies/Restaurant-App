import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/constants_messages.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_detail.dart';
import 'package:restaurant_app/presenter/pages/restaurant_detail/cubit/restaurant_cubit.dart';

class MockGetRestaurantDetail extends Mock implements GetRestaurantDetail {}

void main() {
  RestaurantCubit cubit;
  MockGetRestaurantDetail mockGetRestaurantDetail;

  setUp(() {
    mockGetRestaurantDetail = MockGetRestaurantDetail();

    cubit = RestaurantCubit(mockGetRestaurantDetail);
  });

  group('GetRestaurantDetail', () {
    final testRestaurant = Restaurant();
    final testId = '1abc';

    test('should get data from the use case', () async {
      // arrange
      when(mockGetRestaurantDetail.execute(testId))
          .thenAnswer((realInvocation) async => Right(testRestaurant));
      // act
      cubit.getRestaurant(testId);
      // assert
      verify(mockGetRestaurantDetail.execute(testId));
    });

    blocTest<RestaurantCubit, RestaurantState>(
      'should emit [Loading, Loaded] when data is gotten succesfully',
      build: () {
        when(mockGetRestaurantDetail.execute(testId))
            .thenAnswer((_) async => Right(testRestaurant));
        return cubit;
      },
      act: (cubit) => cubit.getRestaurant(testId),
      expect: [
        RestaurantLoading(),
        RestaurantLoaded(testRestaurant),
      ],
    );

    blocTest<RestaurantCubit, RestaurantState>(
      'should emit [Loading, Error] when unsuccesful',
      build: () {
        when(mockGetRestaurantDetail.execute(testId))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        return cubit;
      },
      act: (context) => cubit.getRestaurant(testId),
      expect: [
        RestaurantLoading(),
        RestaurantError(SERVER_FAILURE_MESSAGE),
      ],
    );
  });
}
