import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:restaurant_app/common/network_info.dart';
import 'package:restaurant_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurant_app/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_detail.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_list.dart';
import 'package:restaurant_app/presenter/pages/restaurant_detail/cubit/restaurant_cubit.dart';
import 'package:restaurant_app/presenter/pages/restaurant_list/cubit/restaurants_cubit.dart';

final locator = GetIt.instance;
void init() {
  locator.registerFactory(
    () => RestaurantsCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RestaurantCubit(
      locator(),
    ),
  );

  locator.registerLazySingleton(() => GetRestaurantList(locator()));
  locator.registerLazySingleton(() => GetRestaurantDetail(locator()));

  locator.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locator()),
  );

  locator.registerLazySingleton(() => Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
