import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/presenter/pages/menu_sheet.dart';
import 'package:restaurant_app/presenter/pages/restaurant_detail/cubit/restaurant_cubit.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  RestaurantDetailPage(this.restaurantId);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    final cubit = context.bloc<RestaurantCubit>();
    cubit.getRestaurant(widget.restaurantId);
  }

  Widget _buildRestaurantInfo(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: secondaryColor,
                    ),
                    Text(restaurant.city),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: secondaryColor,
                    ),
                    Text('${restaurant.rating}'),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Text(
            restaurant.description,
            style: Theme.of(context).textTheme.bodyText2.apply(
                  color: primaryColor500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: OutlineButton(
        child: Text('Show Menus'),
        textColor: secondaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(16),
              ),
            ),
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  top: (MediaQuery.of(_scaffoldKey.currentState.context)
                          .viewPadding
                          .top +
                      64),
                ),
                child: MenuSheet(restaurant),
              );
            },
          );
        },
      ),
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantInitial) {
          return Text('initial');
        } else if (state is RestaurantLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RestaurantLoaded) {
          final restaurant = state.restaurant;
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: 'image_${restaurant.name}',
                        child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}'),
                      ),
                      SafeArea(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: secondaryColor,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      _buildRestaurantInfo(context, restaurant),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _buildMenuButton(context, restaurant),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }
}
