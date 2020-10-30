import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_list.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  final GetRestaurantList _getRestaurantList;

  RestaurantsCubit(this._getRestaurantList) : super(RestaurantsInitial());

  Future<void> getRestaurants() async {
    emit(RestaurantsLoading());
    final restaurantsOrFailure = await _getRestaurantList.execute();

    restaurantsOrFailure.fold(
      (failure) {
        emit(RestaurantsError(failure.toString()));
      },
      (restaurants) {
        emit(RestaurantsLoaded(restaurants));
      },
    );
  }
}
