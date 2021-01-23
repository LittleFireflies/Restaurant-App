import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/exception.dart';
import 'package:restaurant_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurant_app/domain/entities/add_review_response.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/entities/restaurant_detail_response.dart';
import 'package:restaurant_app/domain/entities/restaurant_list_response.dart';

import '../../json_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  RestaurantRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RestaurantRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getRestaurantList', () {
    test('should perform a GET resquest on a URL', () {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((realInvocation) async =>
          http.Response(readJson('restaurant_list.json'), 200));
      // act
      dataSource.getRestaurantList();
      // assert
      verify(mockHttpClient.get('https://restaurant-api.dicoding.dev/list'));
    });

    final testRestaurantResponse = RestaurantListResponse.fromMap(
        json.decode(readJson('restaurant_list.json')));

    test('should return RestaurantListResponse when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((realInvocation) async =>
          http.Response(readJson('restaurant_list.json'), 200));
      // act
      final result = await dataSource.getRestaurantList();
      // assert
      expect(result, testRestaurantResponse);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
          (realInvocation) async => http.Response('Something went wrong', 404));
      // act
      final call = dataSource.getRestaurantList;
      // assert
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('getRestaurantDetail', () {
    final jsonFileName = 'restaurant_detail.json';
    final testId = '1abc';
    final testResponse =
        RestaurantDetailResponse.fromMap(json.decode(readJson(jsonFileName)));

    test('should perform a GET request on a URL', () {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((realInvocation) async =>
          http.Response(readJson('restaurant_detail.json'), 200));
      // act
      dataSource.getRestaurantDetail(testId);
      // assert
      verify(mockHttpClient
          .get('https://restaurant-api.dicoding.dev/detail/$testId'));
    });

    test('should return RestaurantDetailResponse when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response(readJson(jsonFileName), 200));
      // act
      final result = await dataSource.getRestaurantDetail(testId);
      // assert
      expect(result, testResponse);
    });

    test('should throw ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      // act
      final call = dataSource.getRestaurantDetail;
      // assert
      expect(() => call(testId), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('postAddReview', () {
    final jsonFileName = 'customer_review.json';
    final tReview = CustomerReview(
      name: 'tName',
      review: 'tReview',
      date: 'tDate',
    );
    final tResponse =
        AddReviewResponse.fromMap(json.decode(readJson(jsonFileName)));

    test('should perform a POST request on a URL', () {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(readJson(jsonFileName), 200));
      // act
      dataSource.postReview(tReview);
      // assert
      verify(mockHttpClient.post(
        'https://restaurant-api.dicoding.dev/review',
        headers: {'Content-Type': 'application/json'},
        body: tReview,
      ));
    });

    test('should return AddReviewResponse when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(readJson(jsonFileName), 200));
      // act
      final result = await dataSource.postReview(tReview);
      // assert
      expect(result, tResponse);
    });

    test('should throw ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      // act
      final call = dataSource.postReview;
      // assert
      expect(() => call(tReview), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
