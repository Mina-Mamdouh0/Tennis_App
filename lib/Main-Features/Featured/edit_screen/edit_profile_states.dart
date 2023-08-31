abstract class EditProfileState {}

class EditProfileInitialState extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileSuccessState extends EditProfileState {}

class EditProfileErrorState extends EditProfileState {
  final String error;

  EditProfileErrorState({required this.error});
}

class EditProfileValidationErrorState extends EditProfileState {
  final String? nameError;
  final String? phoneNumberError;

  EditProfileValidationErrorState({
    this.nameError,
    this.phoneNumberError,
  });
}
