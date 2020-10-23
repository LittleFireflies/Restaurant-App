import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class MenuTile extends StatelessWidget {
  final String menuName;

  MenuTile(this.menuName);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        menuName,
        style:
            Theme.of(context).textTheme.bodyText1.apply(color: primaryColor500),
      ),
    );
  }
}
