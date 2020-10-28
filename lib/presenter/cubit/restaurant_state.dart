part of 'restaurant_cubit.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
}

class RestaurantInitial extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  const RestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Error: $message';
}
