import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/entities/restaurant.dart';
import 'package:restaurant_app/domain/usecases/get_restaurant_detail.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GetRestaurantDetail _getRestaurantDetail;

  RestaurantCubit(this._getRestaurantDetail) : super(RestaurantInitial());

  Future<void> getRestaurant(String id) async {
    emit(RestaurantLoading());
    final restaurantOrFailure = await _getRestaurantDetail.execute(id);

    restaurantOrFailure.fold(
      (failure) {
        emit(RestaurantError(failure.toString()));
      },
      (restaurant) {
        emit(RestaurantLoaded(restaurant));
      },
    );
  }
}
