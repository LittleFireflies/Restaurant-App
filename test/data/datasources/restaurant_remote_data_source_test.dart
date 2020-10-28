import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/exception.dart';
import 'package:restaurant_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';

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

    final testRestaurantResponse = RestaurantResponse.fromMap(
        json.decode(readJson('restaurant_list.json')));

    test('should return RestaurantResponse when the response code is 200',
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
}
