import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../../models/event.dart';

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

    await eventDocRef.update({'eventImageUrl': imageUrl});
  }
}

Future<void> updateClubWithEvent(String clubId, String eventId) async {
  final DocumentSnapshot clubSnapshot =
      await FirebaseFirestore.instance.collection('clubs').doc(clubId).get();

  if (clubSnapshot.exists) {
    final DocumentReference clubDocRef = clubSnapshot.reference;
    await clubDocRef.update({
      'eventIds': FieldValue.arrayUnion([eventId]),
    });
  } else {
    throw Exception('Club not found with the given ID.');
  }
}

Future<void> updatePlayerWithEvent(String eventId) async {
  final String playerId = FirebaseAuth.instance.currentUser!.uid;
  print('player Id:' + playerId);
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
    throw Exception('Player not found with the given ID.');
  }
}

Future<String> getClubIdFromName(String clubName) async {
  try {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
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

void scheduleEventDeletion(String eventId, DateTime? endDateTime) {
  if (endDateTime != null) {
    final DateTime now = DateTime.now();
    if (endDateTime.isAfter(now)) {
      final Duration difference = endDateTime.difference(now);
      Future.delayed(difference, () {
        deleteEvent(eventId);
        removeEventFromPlayers(eventId);
        removeEventFromClub(eventId);
      });
    } else {
      deleteEvent(eventId);
      removeEventFromPlayers(eventId);
      removeEventFromClub(eventId);
    }
  }
}

Future<void> deleteEvent(String eventId) async {
  try {
    final CollectionReference eventsCollection =
        FirebaseFirestore.instance.collection('events');
    final DocumentReference eventDocRef = eventsCollection.doc(eventId);
    await eventDocRef.delete();
  } catch (error) {
    throw Exception('Failed to delete event: $eventId, Error: $error');
  }
}

Future<void> removeEventFromPlayers(String eventId) async {
  try {
    final QuerySnapshot playerSnapshot = await FirebaseFirestore.instance
        .collection('players')
        .where('eventIds', arrayContains: eventId)
        .get();

    if (playerSnapshot.docs.isNotEmpty) {
      final List<DocumentReference> playerDocRefs =
          playerSnapshot.docs.map((playerDoc) => playerDoc.reference).toList();

      final WriteBatch batch = FirebaseFirestore.instance.batch();
      for (final playerDocRef in playerDocRefs) {
        batch.update(playerDocRef, {
          'eventIds': FieldValue.arrayRemove([eventId]),
        });
      }

      await batch.commit();
    }
  } catch (error) {
    throw Exception('Failed to remove event from players: $error');
  }
}

Future<void> removeEventFromClub(String eventId) async {
  try {
    final QuerySnapshot clubSnapshot = await FirebaseFirestore.instance
        .collection('clubs')
        .where('eventIds', arrayContains: eventId)
        .get();

    if (clubSnapshot.docs.isNotEmpty) {
      final List<DocumentReference> clubDocRefs =
          clubSnapshot.docs.map((clubDoc) => clubDoc.reference).toList();

      final WriteBatch batch = FirebaseFirestore.instance.batch();
      for (final clubDocRef in clubDocRefs) {
        batch.update(clubDocRef, {
          'eventIds': FieldValue.arrayRemove([eventId]),
        });
      }

      await batch.commit();
    }
  } catch (error) {
    throw Exception('Failed to remove event from clubs: $error');
  }
}
