import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/Match.dart';
import '../../../../models/player.dart';

enum PlayingStatus { initial, loading, success, error }

class PlayingCubit extends Cubit<PlayingStatus> {
  PlayingCubit() : super(PlayingStatus.initial);

  Future<void> fetchPlayersDataAndSaveMatchId(
      FindMatch match, FindMatch opponent, BuildContext context) async {
    try {
      emit(PlayingStatus.loading);
      DocumentSnapshot<
          Map<String,
              dynamic>> matchPlayerSnapshot = await FirebaseFirestore.instance
          .collection('players')
          .doc(match
              .userId) // Assuming 'players' is the collection where player data is stored
          .get();

      // Fetch the data for the second player (userId from opponent)
      DocumentSnapshot<
          Map<String,
              dynamic>> opponentPlayerSnapshot = await FirebaseFirestore
          .instance
          .collection('players')
          .doc(opponent
              .userId) // Assuming 'players' is the collection where player data is stored
          .get();

      // Convert the snapshots to Player objects
      Player matchPlayer = Player.fromSnapshot(matchPlayerSnapshot);
      Player opponentPlayer = Player.fromSnapshot(opponentPlayerSnapshot);

      // Add match.matchId for opponentPlayer in matches
      opponentPlayer.matches.add({
        'matchId': opponent.matchId,
        // Add any other relevant match data you want to store in the player's matches list
      });

      // Add opponent.matchId for matchPlayer in matches
      matchPlayer.matches.add({
        'matchId': match.matchId,
        // Add any other relevant match data you want to store in the player's matches list
      });

      // Save the updated player data
      await FirebaseFirestore.instance
          .collection('players')
          .doc(match.userId)
          .update(matchPlayer.toJson());

      await FirebaseFirestore.instance
          .collection('players')
          .doc(opponent.userId)
          .update(opponentPlayer.toJson());

      await FirebaseFirestore.instance
          .collection('matches')
          .doc(match.matchId)
          .update({'isActive': false});
      await FirebaseFirestore.instance
          .collection('matches')
          .doc(opponent.matchId)
          .update({'isActive': false});

      // Show a success message to the user (optional)
      showSnackbar(context, "Match data saved successfully!");
      emit(PlayingStatus.success);
      GoRouter.of(context).push('/home');
    } catch (e) {
      // Emit error state
      emit(PlayingStatus.error);
    }
  }

  // Helper function to show a snackbar with the given message
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
