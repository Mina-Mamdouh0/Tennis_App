abstract class CreateProfileState {}

class CreateProfileInitialState extends CreateProfileState {}

class CreateProfileLoadingState extends CreateProfileState {}

class CreateProfileSuccessState extends CreateProfileState {}

class CreateProfileErrorState extends CreateProfileState {
  final String error;

  CreateProfileErrorState({required this.error});
}

class CreateProfileValidationErrorState extends CreateProfileState {
  final String? nameError;
  final String? phoneNumberError;

  CreateProfileValidationErrorState({
    this.nameError,
    this.phoneNumberError,
  });
}
