import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/constants_messages.dart';
import 'package:restaurant_app/common/failures.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/usecases/add_review.dart';
import 'package:restaurant_app/presenter/pages/review_sheet/cubit/review_cubit.dart';
import 'package:restaurant_app/presenter/pages/review_sheet/cubit/review_state.dart';

class MockAddReview extends Mock implements AddReview {}

void main() {
  ReviewCubit cubit;
  MockAddReview mockAddReview;

  setUp(() {
    mockAddReview = MockAddReview();

    cubit = ReviewCubit(mockAddReview);
  });

  final tReview = CustomerReview(
    name: 'tName',
    review: 'tReview',
    date: 'tDate',
  );

  test('should get data from the use case', () async {
    // arrange
    when(mockAddReview.execute(tReview))
        .thenAnswer((_) async => Right('success'));
    // act
    cubit.addReview(tReview);
    // assert
    verify(mockAddReview.execute(tReview));
  });

  blocTest<ReviewCubit, ReviewState>(
    'should emit [Loading, Success] when data is gotten successfully',
    build: () {
      when(mockAddReview.execute(tReview))
          .thenAnswer((_) async => Right('success'));
      return cubit;
    },
    act: (cubit) => cubit.addReview(tReview),
    expect: [
      ReviewLoading(),
      ReviewSuccess('success'),
    ],
  );

  blocTest<ReviewCubit, ReviewState>(
    'should emit [Loading, Error] when unsuccessful',
    build: () {
      when(mockAddReview.execute(tReview))
          .thenAnswer((_) async => Left(ServerFailure()));
      return cubit;
    },
    act: (cubit) => cubit.addReview(tReview),
    expect: [
      ReviewLoading(),
      ReviewError(SERVER_FAILURE_MESSAGE),
    ],
  );
}
