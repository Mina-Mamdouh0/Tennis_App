abstract class SaveMatchState {}

class SaveMatchInitial extends SaveMatchState {}

class SaveMatchInProgress extends SaveMatchState {}

class SaveMatchSuccess extends SaveMatchState {}

class SaveMatchFailure extends SaveMatchState {
  final String error;
  SaveMatchFailure({required this.error});
}
