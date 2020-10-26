import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/exception.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/common/network_info.dart';
import 'package:restaurant_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurant_app/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';

class MockRemoteDataSource extends Mock implements RestaurantRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  RestaurantRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RestaurantRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getRestaurantList', () {
    final testRestaurantResponse = RestaurantResponse(restaurants: []);

    test('should check if the device is online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getRestaurantList();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getRestaurantList())
            .thenAnswer((realInvocation) async => testRestaurantResponse);
        // act
        final result = await repository.getRestaurantList();
        // assert
        verify(mockRemoteDataSource.getRestaurantList());
        expect(result, equals(Right(testRestaurantResponse)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getRestaurantList())
            .thenThrow(ServerException());
        // act
        final result = await repository.getRestaurantList();
        // assert
        verify(mockRemoteDataSource.getRestaurantList());
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
