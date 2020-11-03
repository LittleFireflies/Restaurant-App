import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/presenter/pages/restaurant_detail/restaurant_detail_page.dart';
import 'package:restaurant_app/presenter/pages/restaurant_list/cubit/restaurants_cubit.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  void initState() {
    super.initState();
    final cubit = context.bloc<RestaurantsCubit>();
    cubit.getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: BlocConsumer<RestaurantsCubit, RestaurantsState>(
        builder: (context, state) {
          if (state is RestaurantsInitial) {
            return Text('Initial');
          } else if (state is RestaurantsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RestaurantsLoaded) {
            final restaurants = state.restaurants;
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
        },
        listener: (context, state) {
          if (state is RestaurantsError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
      ),
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
          arguments: restaurant.id),
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
