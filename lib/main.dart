import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:restaurant_app/common/network_info.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurant_app/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_list.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/pages/restaurant_list_page.dart';
import 'package:restaurant_app/presenter/cubit/restaurant_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => RestaurantCubit(
        GetRestaurantList(
          RestaurantRepositoryImpl(
            remoteDataSource: RestaurantRemoteDataSourceImpl(
              client: Client(),
            ),
            networkInfo: NetworkInfoImpl(
              DataConnectionChecker(),
            ),
          ),
        ),
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: scaffoldColor,
        accentColor: primaryColor500,
        textTheme: textTheme,
      ),
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) =>
            RestaurantDetailPage(ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
