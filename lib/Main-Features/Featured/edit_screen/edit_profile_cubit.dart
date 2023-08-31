import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/utils/widgets/input_date.dart';
import '../../../../models/player.dart';
import '../create_profile/cubits/Gender_Cubit.dart';
import '../create_profile/cubits/player_type_cubit.dart';
import 'edit_profile_states.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final BuildContext context;

  EditProfileCubit(this.context) : super(EditProfileInitialState());

  void saveUserData({
    required TextEditingController nameController,
    required TextEditingController phoneNumberController,
    Uint8List? selectedImageBytes,
    TimeOfDay? selectedTime,
    required BuildContext context,
    Player? currentPlayer,
  }) async {
    emit(EditProfileLoadingState());

    try {
      String? nameError = validateName(nameController.text);
      String? phoneNumberError =
          validatePhoneNumber(phoneNumberController.text);

      if (nameError != null || phoneNumberError != null) {
        emit(EditProfileValidationErrorState(
          nameError: nameError,
          phoneNumberError: phoneNumberError,
        ));
        return;
      }
      if (currentPlayer == null) {
        // If there is no authenticated user, return and show an error
        emit(EditProfileErrorState(error: "No authenticated user found."));
        return;
      }

      // Get the currently authenticated user ID
      String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';

      // Create a new Player object with the updated properties
      Player player = Player(
        playerId: playerId, // Use the UID as the player ID
        playerName: nameController.text.isEmpty
            ? currentPlayer.playerName
            : nameController.text,
        phoneNumber: phoneNumberController.text.isEmpty
            ? currentPlayer.phoneNumber
            : phoneNumberController.text,
        photoURL: currentPlayer.photoURL,
        playerLevel: currentPlayer.playerLevel,
        matchPlayed: currentPlayer.matchPlayed,
        totalWins: currentPlayer.totalWins,
        skillLevel: currentPlayer.skillLevel,
        gender: context.read<GenderCubit>().state.isEmpty
            ? currentPlayer.gender
            : context.read<GenderCubit>().state,
        birthDate: context.read<DateCubit>().state,
        preferredPlayingTime: selectedTime != null
            ? '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}'
            : '',
        playerType: context.read<PlayerTypeCubit>().state,
        eventIds: currentPlayer.eventIds,
        clubRoles: currentPlayer.clubRoles,
        clubInvitationsIds: currentPlayer.clubInvitationsIds,
        participatedClubId: currentPlayer.participatedClubId,
        matches: currentPlayer.matches,
        reversedCourtsIds: currentPlayer.reversedCourtsIds,
        chatIds: currentPlayer.chatIds,
        doubleMatchesIds: currentPlayer.doubleMatchesIds,
        doubleTournamentsIds: currentPlayer.doubleTournamentsIds,
        singleMatchesIds: currentPlayer.singleMatchesIds,
        singleTournamentsIds: currentPlayer.singleTournamentsIds,
      );

      CollectionReference playersCollection =
          FirebaseFirestore.instance.collection('players');
      DocumentReference playerDocRef = playersCollection.doc(playerId);

      await playerDocRef.set(player.toJson());

      // Upload the selected image to Firebase Storage
      if (selectedImageBytes != null) {
        firebase_storage.Reference storageReference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('players')
            .child(playerId)
            .child('profile-image.jpg');
        firebase_storage.UploadTask uploadTask =
            storageReference.putData(selectedImageBytes);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        // Update the player document with the image URL
        await playerDocRef.update({'photoURL': imageUrl});
      }

      // Data saved successfully
      print('User data saved successfully.');

      emit(EditProfileSuccessState());
      GoRouter.of(context).push('/chooseClub');
    } catch (error) {
      emit(EditProfileErrorState(error: error.toString()));
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Add additional phone number validation if needed
    return null;
  }
}
