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
import '../../../../models/double_match.dart';
import '../../../../models/single_match.dart';
import 'double_match_state.dart';

class DoubleMatchCubit extends Cubit<DoubleMatchState> {
  final BuildContext context;

  DoubleMatchCubit(this.context) : super(DoubleMatchInitial());

  void saveDoubleMatch({
    required Player selectedPlayer,
    required Player selectedPlayer2,
    required Player selectedPlayer3,
    required Player selectedPlayer4,
    required TextEditingController courtNameController,
  }) async {
    emit(DoubleMatchInProgress());

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

      // Create a DoubleMatch object
      DoubleMatch doubleMatch = DoubleMatch(
        matchId: '', // Firestore will generate a unique match ID
        player1Id: selectedPlayer.playerId,
        player2Id: selectedPlayer2.playerId,
        startTime: startTime,
        endTime: endTime,
        courtName: courtName,
        player3Id: selectedPlayer3.playerId,
        player4Id: selectedPlayer4.playerId,
        winner1: '',
        winner2: '',
      );

      // Save the DoubleMatch object to Firestore
      final newMatchRef = await FirebaseFirestore.instance
          .collection('double_matches')
          .add(doubleMatch.toFirestore());

      // Update the DoubleMatch object with the generated match ID
      doubleMatch.matchId = newMatchRef.id;

      // Fetch the players based on their IDs
      final player1Doc = await FirebaseFirestore.instance
          .collection('players')
          .doc(doubleMatch.player1Id)
          .get();
      final player2Doc = await FirebaseFirestore.instance
          .collection('players')
          .doc(doubleMatch.player2Id)
          .get();
      final player3Doc = await FirebaseFirestore.instance
          .collection('players')
          .doc(doubleMatch.player3Id)
          .get();
      final player4Doc = await FirebaseFirestore.instance
          .collection('players')
          .doc(doubleMatch.player4Id)
          .get();

      final player1 = Player.fromSnapshot(player1Doc);
      final player2 = Player.fromSnapshot(player2Doc);
      final player3 = Player.fromSnapshot(player3Doc);
      final player4 = Player.fromSnapshot(player4Doc);

      // Update the players' doubleMatchesIds lists with the new match ID
      player1.doubleMatchesIds.add(doubleMatch.matchId);
      player2.doubleMatchesIds.add(doubleMatch.matchId);
      player3.doubleMatchesIds.add(doubleMatch.matchId);
      player4.doubleMatchesIds.add(doubleMatch.matchId);

      // Update the players' documents with the updated lists
      await player1Doc.reference
          .update({'doubleMatchesIds': player1.doubleMatchesIds});
      await player2Doc.reference
          .update({'doubleMatchesIds': player2.doubleMatchesIds});
      await player3Doc.reference
          .update({'doubleMatchesIds': player3.doubleMatchesIds});
      await player4Doc.reference
          .update({'doubleMatchesIds': player4.doubleMatchesIds});

      Method method = Method();
      Player currentUser = await method.getCurrentUser();
      Club clubData =
          await method.fetchClubData(currentUser.participatedClubId);
      clubData.doubleMatchesIds.add(newMatchRef.id);
      await FirebaseFirestore.instance
          .collection('clubs')
          .doc(currentUser.participatedClubId)
          .update({
        'doubleMatchesIds': clubData.doubleMatchesIds,
      });

      emit(DoubleMatchSuccess());
    } catch (e) {
      emit(DoubleMatchFailure(error: e.toString()));
    }
  }
}
