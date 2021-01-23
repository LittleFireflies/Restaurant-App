import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/exception.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/common/network_info.dart';
import 'package:restaurant_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurant_app/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/entities/add_review_response.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/entities/restaurant_detail_response.dart';
import 'package:restaurant_app/domain/entities/restaurant_list_response.dart';

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

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getRestaurantList', () {
    final testRestaurantResponse = RestaurantListResponse(restaurants: []);

    test('should check if the device is online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getRestaurantList())
          .thenAnswer((realInvocation) async => testRestaurantResponse);
      // act
      repository.getRestaurantList();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
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
        expect(result, equals(Right(testRestaurantResponse.restaurants)));
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

    runTestOffline(() {
      test('should return connection failure when the device is offline',
          () async {
        // arrange
        when(mockRemoteDataSource.getRestaurantList())
            .thenThrow(SocketException("Can't connect to the network"));
        // act
        final result = await repository.getRestaurantList();
        // assert
        verify(mockRemoteDataSource.getRestaurantList());
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });

  group('getRestaurantDetail', () {
    final testResponse = RestaurantDetailResponse(restaurant: Restaurant());
    final testRestaurantId = '1abc';

    test('should check if the device is online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getRestaurantDetail(testRestaurantId))
          .thenAnswer((_) async => testResponse);
      // act
      repository.getRestaurantDetail(testRestaurantId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getRestaurantDetail(testRestaurantId))
            .thenAnswer((_) async => testResponse);
        // act
        final result = await repository.getRestaurantDetail(testRestaurantId);
        // assert
        verify(mockRemoteDataSource.getRestaurantDetail(testRestaurantId));
        expect(result, equals(Right(testResponse.restaurant)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getRestaurantDetail(testRestaurantId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getRestaurantDetail(testRestaurantId);
        // assert
        verify(mockRemoteDataSource.getRestaurantDetail(testRestaurantId));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('should return connection failure when the device is offline',
          () async {
        // arrange
        when(mockRemoteDataSource.getRestaurantDetail(testRestaurantId))
            .thenThrow(SocketException("Can't connect to the network"));
        // act
        final result = await repository.getRestaurantDetail(testRestaurantId);
        // assert
        verify(mockRemoteDataSource.getRestaurantDetail(testRestaurantId));
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });

  group('Add Review', () {
    final tResponse = AddReviewResponse(
      error: false,
      message: 'success',
    );
    final tReview = CustomerReview(
      name: 'tName',
      review: 'tReview',
      date: 'tDate',
    );

    test('should check if the device is online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.postReview(tReview))
          .thenAnswer((_) async => tResponse);
      // act
      repository.addReview(tReview);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.postReview(tReview))
            .thenAnswer((_) async => tResponse);
        // act
        final result = await repository.addReview(tReview);
        // assert
        verify(mockRemoteDataSource.postReview(tReview));
        expect(result, equals(Right(tResponse.message)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.postReview(tReview))
            .thenThrow(ServerException());
        // act
        final result = await repository.addReview(tReview);
        // assert
        verify(mockRemoteDataSource.postReview(tReview));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('should return connection failure when the device is offline',
          () async {
        // arrange
        when(mockRemoteDataSource.postReview(tReview))
            .thenThrow(SocketException("Can't connect to the network"));
        // act
        final result = await repository.addReview(tReview);
        // assert
        verify(mockRemoteDataSource.postReview(tReview));
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });
}
