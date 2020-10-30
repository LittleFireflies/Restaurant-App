import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/constants_messages.dart';
import 'package:restaurant_app/common/failures.dart';
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
        if (failure is ServerFailure) {
          emit(RestaurantError(SERVER_FAILURE_MESSAGE));
        } else if (failure is ConnectionFailure) {
          emit(RestaurantError(CONNECTION_FAILURE_MESSAGE));
        } else {
          emit(RestaurantError('Application Error'));
        }
      },
      (restaurant) {
        emit(RestaurantLoaded(restaurant));
      },
    );
  }
}
