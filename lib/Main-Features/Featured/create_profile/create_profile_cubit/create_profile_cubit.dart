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
import '../cubits/Gender_Cubit.dart';
import '../cubits/player_type_cubit.dart';
import 'create_profile_states.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  final BuildContext context;

  CreateProfileCubit(this.context) : super(CreateProfileInitialState());

  void saveUserData({
    required TextEditingController nameController,
    required TextEditingController phoneNumberController,
    Uint8List? selectedImageBytes,
    TimeOfDay? selectedTime,
    required BuildContext context,
  }) async {
    emit(CreateProfileLoadingState());

    try {
      String? nameError = validateName(nameController.text);
      String? phoneNumberError =
          validatePhoneNumber(phoneNumberController.text);

      if (nameError != null || phoneNumberError != null) {
        emit(CreateProfileValidationErrorState(
          nameError: nameError,
          phoneNumberError: phoneNumberError,
        ));
        return;
      }

      String selectedGender = context.read<GenderCubit>().state;
      String playerName = nameController.text;
      String phoneNumber = phoneNumberController.text;
      DateTime? selectedDateTime = context.read<DateCubit>().state;
      String? selectedPlayerType = context.read<PlayerTypeCubit>().state;

      // Get the currently authenticated user ID
      String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';

      Player player = Player(
        playerId: playerId, // Use the UID as the player ID
        playerName: playerName,
        phoneNumber: phoneNumber,
        photoURL: '',
        playerLevel: '',
        matchPlayed: 0,
        totalWins: 0,
        skillLevel: '',
        gender: selectedGender,
        birthDate: selectedDateTime,
        preferredPlayingTime: selectedTime != null
            ? '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}'
            : '',
        playerType: selectedPlayerType,
        eventIds: [], clubRoles: {}, clubInvitationsIds: [],
        participatedClubId: '',
        matches: [],
        reversedCourtsIds: [],
        chatIds: [],
        doubleMatchesIds: [],
        doubleTournamentsIds: [],
        singleMatchesIds: [],
        singleTournamentsIds: [],
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

      emit(CreateProfileSuccessState());
      GoRouter.of(context).push('/chooseClub');
    } catch (error) {
      emit(CreateProfileErrorState(error: error.toString()));
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
