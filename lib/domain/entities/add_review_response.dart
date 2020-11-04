import 'package:equatable/equatable.dart';

class AddReviewResponse extends Equatable {
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

  @override
  List<Object> get props => [error, message];
}
