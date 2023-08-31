import '../../../../models/Match.dart';

abstract class FindMatchState {}

class FindMatchInitial extends FindMatchState {}

class FindMatchLoading extends FindMatchState {}

class FindMatchSuccess extends FindMatchState {
  final FindMatch match; // Include the Matches object as a property

  FindMatchSuccess(this.match);
}

class FindMatchError extends FindMatchState {
  final String errorMessage;

  FindMatchError(this.errorMessage);
}
