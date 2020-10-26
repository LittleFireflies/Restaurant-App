import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/exception.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/common/network_info.dart';
import 'package:restaurant_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RestaurantRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, RestaurantResponse>> getRestaurantList() async {
    networkInfo.isConnected;
    try {
      final remoteRestaurantResponse =
          await remoteDataSource.getRestaurantList();
      return Right(remoteRestaurantResponse);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
