import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/presenter/pages/restaurant_detail/cubit/restaurant_cubit.dart';
import 'package:restaurant_app/presenter/pages/restaurant_detail/restaurant_detail_page.dart';
import 'package:restaurant_app/presenter/pages/restaurant_list/cubit/restaurants_cubit.dart';
import 'package:restaurant_app/presenter/pages/restaurant_list/restaurant_list_page.dart';
import 'package:restaurant_app/injection_container.dart' as injector;

void main() {
  injector.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector.locator<RestaurantsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.locator<RestaurantCubit>(),
        ),
      ],
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
