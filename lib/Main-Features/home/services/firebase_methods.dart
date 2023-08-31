import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void navigateToCreateEvent(BuildContext context) async {
  final String playerId = FirebaseAuth.instance.currentUser!.uid;
  final DocumentSnapshot<Map<String, dynamic>> playerSnapshot =
      await FirebaseFirestore.instance
          .collection('players')
          .doc(playerId)
          .get();

  if (playerSnapshot.exists) {
    final playerData = playerSnapshot.data()!;
    final String clubIds = (playerData['participatedClubId'] ?? '').trim();

    if (clubIds.isNotEmpty) {
      GoRouter.of(context).push('/createEvent');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('No Club Membership'),
            content: const Text(
                'You need to be a member of a club to create an event.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Player Not Found'),
          content: const Text('Player not found with the given ID.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
