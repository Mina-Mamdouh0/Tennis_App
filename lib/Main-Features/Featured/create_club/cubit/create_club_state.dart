abstract class CreateClubState {}

class CreateClubInitialState extends CreateClubState {}

class CreateClubLoadingState extends CreateClubState {}

class CreateClubSuccessState extends CreateClubState {}

class CreateClubErrorState extends CreateClubState {
  final String error;

  CreateClubErrorState({required this.error});
}
