import 'package:equatable/equatable.dart';

class Menus extends Equatable {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Menu> foods;
  List<Menu> drinks;

  factory Menus.fromMap(Map<String, dynamic> json) => Menus(
        foods: List<Menu>.from(json["foods"].map((x) => Menu.fromMap(x))),
        drinks: List<Menu>.from(json["drinks"].map((x) => Menu.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toMap())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toMap())),
      };

  @override
  List<Object> get props => [foods, drinks];
}

class Menu extends Equatable {
  Menu({
    this.name,
  });

  String name;

  factory Menu.fromMap(Map<String, dynamic> json) => Menu(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };

  @override
  List<Object> get props => [name];
}
