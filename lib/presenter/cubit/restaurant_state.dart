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
  final RestaurantResponse restaurantResponse;
  const RestaurantLoaded(this.restaurantResponse);

  @override
  List<Object> get props => [restaurantResponse];
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Error: $message';
}
