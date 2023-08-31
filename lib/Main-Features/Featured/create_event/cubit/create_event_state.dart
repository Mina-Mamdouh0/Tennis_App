abstract class CreateEventState {}

class CreateEventInitialState extends CreateEventState {}

class CreateEventLoadingState extends CreateEventState {}

class CreateEventSuccessState extends CreateEventState {}

class CreateEventErrorState extends CreateEventState {
  final String error;

  CreateEventErrorState({required this.error});
}
