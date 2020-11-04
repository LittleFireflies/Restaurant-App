import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class ReviewInitial extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoading extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewSuccess extends ReviewState {
  final String message;
  const ReviewSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Error: $message';
}
