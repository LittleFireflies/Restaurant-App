import 'package:restaurant_app/domain/entities/customer_review.dart';

class AddReviewResponse {
  final bool error;
  final String message;

  AddReviewResponse({
    this.error,
    this.message,
  });

  factory AddReviewResponse.fromMap(Map<String, dynamic> json) =>
      AddReviewResponse(
        error: json['error'],
        message: json['message'],
      );

  Map<String, dynamic> toMap() => {
        'error': error,
        'message': message,
      };
}
