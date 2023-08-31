import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerNamesCubit extends Cubit<List<String>> {
  PlayerNamesCubit() : super([]);

  Future<void> fetchCreatedClubId(String playerId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('players')
              .doc(playerId)
              .get();
      final createdClubId = snapshot.data()?['participatedClubId'] as String?;

      if (createdClubId != null) {
        fetchClubMemberIds(createdClubId);
      } else {
        // If createdClubId is null, it means the playerId doesn't have a created club.
        emit([]);
      }
    } catch (error) {
      emit([]);
      throw Exception('Failed to fetch created club ID: $error');
    }
  }

  Future<void> fetchClubMemberIds(String clubId) async {
    try {
      // Step 1: Fetch the club data from the 'clubs' collection based on the provided clubId
      final DocumentSnapshot<Map<String, dynamic>> clubSnapshot =
          await FirebaseFirestore.instance
              .collection('clubs')
              .doc(clubId)
              .get();

      // Step 2: Get the 'memberIds' list from the club data, or an empty list if it's null
      final clubData = clubSnapshot.data();
      final List<dynamic>? clubMemberIdsRaw = clubData?['memberIds'];
      final List<String> clubMemberIds =
          List<String>.from(clubMemberIdsRaw ?? []);
      print(clubData);
      print(clubMemberIdsRaw);

      fetchPlayerNames(clubMemberIds);
    } catch (error) {
      emit([]);
      throw Exception('Failed to fetch club memberIds: $error');
    }
  }

  Future<void> fetchPlayerNames(List<String> playerIds) async {
    try {
      // Step 1: Fetch the player data from the 'players' collection based on the provided playerIds
      final List<Future<DocumentSnapshot<Map<String, dynamic>>>>
          playerSnapshotsFutures = playerIds
              .map((playerId) => FirebaseFirestore.instance
                  .collection('players')
                  .doc(playerId)
                  .get())
              .toList();
      print(playerSnapshotsFutures);
      // Step 2: Wait for all the playerSnapshots to complete
      final List<DocumentSnapshot<Map<String, dynamic>>> playerSnapshots =
          await Future.wait(playerSnapshotsFutures);

      // Step 3: Extract the names from each playerSnapshot and emit the result
      final List<String> playerNames = playerSnapshots
          .map((snapshot) => snapshot.data()?['playerName'] as String?)
          .whereType<String>()
          .toList();
      print(playerNames);

      emit(playerNames); // Emit the player names to the UI
    } catch (error) {
      throw Exception('Failed to fetch player names: $error');
    }
  }
}
