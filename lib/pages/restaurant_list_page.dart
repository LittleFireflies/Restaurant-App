import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/presenter/cubit/restaurant_cubit.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  void initState() {
    super.initState();
    final cubit = context.bloc<RestaurantCubit>();
    cubit.getRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
        if (state is RestaurantInitial) {
          return Text('Initial');
        } else if (state is RestaurantLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RestaurantLoaded) {
          final restaurants = state.restaurantResponse.restaurants;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantItem(restaurant);
            },
          );
        } else {
          return Text('Error');
        }
      }),
    );
  }
}

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: 'image_${restaurant.name}',
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                  width: 100,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: 20,
                            color: primaryColor,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          restaurant.city,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: primaryColor500),
                        ),
                        SizedBox(width: 8),
                        Text('-'),
                        SizedBox(width: 8),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: primaryColor500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
