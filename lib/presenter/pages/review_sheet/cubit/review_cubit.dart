import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/constants_messages.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/usecases/add_review.dart';
import 'package:restaurant_app/presenter/pages/review_sheet/cubit/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final AddReview _addReview;

  ReviewCubit(this._addReview) : super(ReviewInitial());

  void addReview(CustomerReview review) async {
    emit(ReviewLoading());

    final successOrFail = await _addReview.execute(review);

    successOrFail.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(ReviewError(SERVER_FAILURE_MESSAGE));
        } else if (failure is ConnectionFailure) {
          emit(ReviewError(CONNECTION_FAILURE_MESSAGE));
        } else {
          emit(ReviewError('Application Error'));
        }
      },
      (r) => emit(ReviewSuccess(r)),
    );
  }
}
