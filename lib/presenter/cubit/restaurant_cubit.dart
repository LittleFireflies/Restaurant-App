import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_list.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GetRestaurantList _getRestaurantList;

  RestaurantCubit(this._getRestaurantList) : super(RestaurantInitial());

  Future<void> getRestaurant() async {
    emit(RestaurantLoading());
    final restaurantsOrFailure = await _getRestaurantList.execute();

    restaurantsOrFailure.fold(
      (failure) {
        emit(RestaurantError(failure.toString()));
      },
      (restaurants) {
        emit(RestaurantLoaded(restaurants));
      },
    );
  }
}
