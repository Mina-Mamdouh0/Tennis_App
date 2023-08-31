import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tennis_app/Main-Features/Featured/create_court/cubit/create_court_states.dart';

import '../../../../core/utils/widgets/input_date_and_time.dart';
import '../../../../models/court.dart';
import '../../create_event/view/widgets/input_end_date.dart';

class CreateCourtCubit extends Cubit<CreateCourtState> {
  CreateCourtCubit(this.context) : super(CreateCourtInitialState());
  final BuildContext context;

  void saveCourtData({
    required TextEditingController courtNameController,
    required TextEditingController phoneController,
    required TextEditingController addressController,
    Uint8List? selectedImageBytes,
  }) async {
    emit(CreateCourtLoadingState());
    try {
      String courtName = courtNameController.text;
      String phoneNumber = phoneController.text;
      String address = addressController.text;
      DateTime? selectedStartDateTime = context.read<DateTimeCubit>().state;
      DateTime? selectedEndDateTime = context.read<EndDateTimeCubit>().state;
      Court court = Court(
          courtId: '', // Assign a court ID here if applicable
          courtName: courtName,
          phoneNumber: phoneNumber,
          startDate: selectedStartDateTime,
          endDate: selectedEndDateTime,
          courtAddress: address,
          photoURL: '',
          reversed: false);

      CollectionReference courtsCollection =
          FirebaseFirestore.instance.collection('courts');
      DocumentReference courtDocRef =
          await courtsCollection.add(court.toJson());

      // Get the ID of the newly created court document
      String newCourtId = courtDocRef.id;

      // Update the court document with the retrieved ID
      await courtDocRef.update({'courtId': newCourtId});

      // Upload the selected image to Firebase Storage
      if (selectedImageBytes != null) {
        firebase_storage.Reference storageReference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('courts')
            .child(newCourtId)
            .child('court-image.jpg');
        firebase_storage.UploadTask uploadTask =
            storageReference.putData(selectedImageBytes);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        // Update the court document with the image URL
        await courtDocRef.update({'photoURL': imageUrl});
      }

      // You can emit a success state if needed
      emit(CreateCourtSuccessState());

      // Redirect to the next screen using GoRouter
      GoRouter.of(context).push('/home');
    } catch (error) {
      // Handle the error if needed
      emit(CreateCourtErrorState(error: error.toString()));
      print('Error: $error');
    }
  }
}
