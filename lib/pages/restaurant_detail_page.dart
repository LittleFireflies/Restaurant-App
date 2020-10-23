import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/pages/menu_sheet.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  RestaurantDetailPage(this.restaurant);

  Widget _buildRestaurantInfo(BuildContext context) {
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

  Widget _buildMenuButton(BuildContext context) {
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
                  child: Image.network(restaurant.pictureId),
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
                _buildRestaurantInfo(context),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildMenuButton(context),
    );
  }
}
