part of 'restaurants_cubit.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();
}

class RestaurantsInitial extends RestaurantsState {
  @override
  List<Object> get props => [];
}

class RestaurantsLoading extends RestaurantsState {
  @override
  List<Object> get props => [];
}

class RestaurantsLoaded extends RestaurantsState {
  final List<Restaurant> restaurants;
  const RestaurantsLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantsError extends RestaurantsState {
  final String message;

  const RestaurantsError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Error: $message';
}
