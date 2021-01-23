import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/domain/usecases/add_review.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  AddReview usecase;
  MockRestaurantRepository repository;

  setUp(() {
    repository = MockRestaurantRepository();
    usecase = AddReview(repository);
  });

  final String testMessage = 'success';
  final testReview = CustomerReview(
    name: 'tName',
    review: 'tReview',
    date: 'tDate',
  );

  test('should send review to repository', () async {
    // arrange
    when(repository.addReview(testReview))
        .thenAnswer((_) async => Right(testMessage));
    // act
    final result = await usecase.execute(testReview);
    // assert
    expect(result, Right(testMessage));
    verify(repository.addReview(testReview));
    verifyNoMoreInteractions(repository);
  });
}
