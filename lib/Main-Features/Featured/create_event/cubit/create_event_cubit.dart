import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/utils/widgets/input_date_and_time.dart';

import '../../../../models/club.dart';
import '../../../../models/event.dart';
import '../../create_event/cubit/create_event_state.dart';
import '../../create_event/view/widgets/event_types.dart';
import '../view/widgets/input_end_date.dart';
import '../view/widgets/player_level.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit(this.context) : super(CreateEventInitialState());
  final BuildContext context;

  void saveEventData(
      {required TextEditingController eventNameController,
      required TextEditingController addressController,
      required TextEditingController courtNameController,
      required TextEditingController instructionsController,
      Uint8List? selectedImageBytes,
      required BuildContext context,
      required List<String>? selected}) async {
    try {
      emit(CreateEventLoadingState());

      final String eventName = eventNameController.text;
      final String eventAddress = addressController.text;
      final String courtName = courtNameController.text;
      final String instructions = instructionsController.text;
      DateTime? selectedStartDateTime = context.read<DateTimeCubit>().state;
      DateTime? selectedEndDateTime = context.read<EndDateTimeCubit>().state;
      final EventType selectedEventType = context.read<EventTypeCubit>().state;
      final double level = context.read<SliderCubit>().state;

      final CollectionReference eventsCollection =
          FirebaseFirestore.instance.collection('events');
      final DocumentReference eventDocRef = eventsCollection.doc();

      final String eventId = eventDocRef.id;

      final Event event = Event(
        eventId: eventId,
        eventName: eventName,
        eventStartAt: selectedStartDateTime,
        eventEndsAt: selectedEndDateTime,
        eventAddress: eventAddress,
        eventType: selectedEventType.toString().split('.').last,
        courtName: courtName,
        instructions: instructions,
        playerIds: [],
        playerLevel: level,
        clubId: '',
      );

      await saveEventDocument(eventDocRef, event);
      await uploadEventImage(eventDocRef, selectedImageBytes);
      if (selected!.isNotEmpty) {
        await updatePlayersWithEvent(eventDocRef.id, selected!);
      } else {
        await updateClubWithEvent(eventDocRef.id);
      }

      emit(CreateEventSuccessState());

      GoRouter.of(context).push('/home');
    } catch (error) {
      emit(CreateEventErrorState(error: error.toString()));
      print('Error: $error');
    }
  }

  Future<void> saveEventDocument(
      DocumentReference eventDocRef, Event event) async {
    await eventDocRef.set(event.toJson());
  }

  Future<void> uploadEventImage(
      DocumentReference eventDocRef, Uint8List? selectedImageBytes) async {
    if (selectedImageBytes != null) {
      final firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('events')
          .child(eventDocRef.id)
          .child('event-image.jpg');
      final firebase_storage.UploadTask uploadTask =
          storageReference.putData(selectedImageBytes);
      final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await eventDocRef.update({'photoURL': imageUrl});
    }
  }

  Future<void> updateClubWithEvent(String eventId) async {
    final String playerId = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot playerSnapshot = await FirebaseFirestore.instance
        .collection('players')
        .doc(playerId)
        .get();

    final String participatedClubId = playerSnapshot['participatedClubId'];

    if (participatedClubId.isNotEmpty) {
      // Fetch the club data using the participatedClubId
      final clubSnapshot = await FirebaseFirestore.instance
          .collection('clubs')
          .doc(participatedClubId)
          .get();

      if (clubSnapshot.exists) {
        final Club club = Club.fromSnapshot(clubSnapshot);

        // Now you have the club data with the participated event and can perform further updates.
        // For example, you can update the eventIds list in the club document.
        final updatedEventIds = [...club.eventIds, eventId];

        await FirebaseFirestore.instance
            .collection('clubs')
            .doc(participatedClubId)
            .update({'eventIds': updatedEventIds});
      }
    }
  }

  Future<void> updatePlayersWithEvent(
      String eventId, List<String> playersId) async {
    final String playerId = FirebaseAuth.instance.currentUser!.uid;
    playersId.add(playerId);
    for (String playerId in playersId) {
      final DocumentSnapshot playerSnapshot = await FirebaseFirestore.instance
          .collection('players')
          .doc(playerId)
          .get();

      if (playerSnapshot.exists) {
        final DocumentReference playerDocRef = playerSnapshot.reference;
        await playerDocRef.update({
          'eventIds': FieldValue.arrayUnion([eventId]),
        });
      } else {
        // Handle the case when the player is not found with the given ID.
        print('Player not found with the ID: $playerId');
      }
    }
  }

  Future<String> getClubIdFromName(String clubName) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('clubs')
              .where('clubName', isEqualTo: clubName)
              .get();

      if (snapshot.docs.isNotEmpty) {
        final clubDoc = snapshot.docs.first;
        return clubDoc.id;
      } else {
        throw Exception('Club not found with the given name.');
      }
    } catch (error) {
      throw Exception('Failed to get club ID from name: $error');
    }
  }
}
