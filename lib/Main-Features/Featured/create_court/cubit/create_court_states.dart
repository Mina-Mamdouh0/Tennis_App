abstract class CreateCourtState {}

class CreateCourtInitialState extends CreateCourtState {}

class CreateCourtLoadingState extends CreateCourtState {}

class CreateCourtSuccessState extends CreateCourtState {}

class CreateCourtErrorState extends CreateCourtState {
  final String error;

  CreateCourtErrorState({required this.error});
}
