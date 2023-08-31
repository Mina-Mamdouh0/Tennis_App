import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Main-Features/create_event_match/single_friendly_match/cubit/single_match_state.dart';
import 'package:tennis_app/models/player.dart';

import '../../../Featured/create_event/view/widgets/input_end_date.dart';
import '../../../../core/methodes/firebase_methodes.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../../core/utils/widgets/input_date_and_time.dart';
import '../../../../models/club.dart';
import '../../../../models/single_match.dart';

class SaveMatchCubit extends Cubit<SaveMatchState> {
  final BuildContext context;

  SaveMatchCubit(this.context) : super(SaveMatchInitial());

  void saveMatch({
    required Player selectedPlayer,
    required Player selectedPlayer2,
    required TextEditingController courtNameController,
  }) async {
    emit(SaveMatchInProgress());

    try {
      // Check if all required data is available
      if (selectedPlayer == null || selectedPlayer2 == null) {
        // Display a message or alert to inform the user that both players need to be selected
        return showSnackBar(context, 'You Must Choose Two Players');
      }
      DateTime? selectedStartDateTime = context.read<DateTimeCubit>().state;
      DateTime? selectedEndDateTime = context.read<EndDateTimeCubit>().state;
      // Get the selected date and time from InputDateAndTime widget and convert it to DateTime object
      DateTime startTime = selectedStartDateTime;

      // Get the selected end date and time from InputEndDateAndTime widget and convert it to DateTime object
      DateTime endTime = selectedEndDateTime;

      // Get the court name from the text controller
      String courtName = courtNameController.text.trim();

      // Create a SingleMatch object
      SingleMatch singleMatch = SingleMatch(
        matchId:
            '', // You can generate a unique match ID or leave it empty for Firestore to generate one
        player1Id: selectedPlayer.playerId,
        player2Id: selectedPlayer2.playerId,
        startTime: startTime,
        endTime: endTime,
        winner: '',
        courtName: courtName,
      );

      // Save the SingleMatch object to Firestore
      final newMatchRef = await FirebaseFirestore.instance
          .collection('single_matches')
          .add(singleMatch.toFirestore());

      singleMatch.matchId = newMatchRef.id;
      // Fetch the players based on their IDs
      final player1Doc = await FirebaseFirestore.instance
          .collection('players')
          .doc(singleMatch.player1Id)
          .get();
      final player2Doc = await FirebaseFirestore.instance
          .collection('players')
          .doc(singleMatch.player2Id)
          .get();

      final player1 = Player.fromSnapshot(player1Doc);
      final player2 = Player.fromSnapshot(player2Doc);

      player1.singleMatchesIds.add(singleMatch.matchId);
      player2.singleMatchesIds.add(singleMatch.matchId);

      // Update the players' documents with the updated lists
      await player1Doc.reference
          .update({'singleMatchesIds': player1.singleMatchesIds});
      await player2Doc.reference
          .update({'singleMatchesIds': player2.singleMatchesIds});

      Method method = Method();
      Player currentUser = await method.getCurrentUser();
      Club clubData =
          await method.fetchClubData(currentUser.participatedClubId);
      clubData.singleMatchesIds.add(newMatchRef.id);
      await FirebaseFirestore.instance
          .collection('clubs')
          .doc(currentUser.participatedClubId)
          .update({
        'singleMatchesIds': clubData.singleMatchesIds,
      });
      // Display a success message or navigate to a new screen after saving successfully
      // Handle any errors that occur during the save process
      emit(SaveMatchSuccess());
    } catch (e) {
      emit(SaveMatchFailure(error: e.toString()));
    }
  }
}
