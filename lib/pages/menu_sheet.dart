import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/widgets/menu_tile.dart';

class MenuSheet extends StatelessWidget {
  final Restaurant restaurant;

  MenuSheet(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: scaffoldColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menu',
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        'Foods',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    restaurant.menus.foods
                        .map((food) => MenuTile(food.name))
                        .toList(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        'Drinks',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    restaurant.menus.drinks
                        .map((drink) => MenuTile(drink.name))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.close,
                    color: primaryColor,
                  ),
                  onPressed: () => Navigator.pop(context)),
            ],
          )
        ],
      ),
    );
  }
}
