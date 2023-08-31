import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/club.dart';
import '../../../../models/player.dart';
import 'club_management_state.dart';

class ClubManagementCubit extends Cubit<ClubManagementState> {
  ClubManagementCubit() : super(ClubManagementInitial());

  Future<void> fetchClubData(String? createdClubId) async {
    emit(ClubManagementLoading());
    if (createdClubId != null && createdClubId.isNotEmpty) {
      final clubSnapshot = await FirebaseFirestore.instance
          .collection('clubs')
          .doc(createdClubId)
          .get();

      if (clubSnapshot.exists) {
        final clubData = clubSnapshot.data();
        if (clubData != null) {
          final List<String> memberIds =
              List<String>.from(clubData['memberIds'] ?? []);

          try {
            List<Player> members = await fetchMembersData(memberIds);
            print(memberIds.length);
            // Create the club object using the Club class
            Club club = Club.fromSnapshot(clubSnapshot);
            print(club.clubId);
            emit(ClubManagementLoaded(club: club, members: members));
          } catch (error) {
            print("Error fetching members data: $error"); // Add debug print
            emit(ClubManagementError('Error fetching members data'));
          }
        } else {
          // If club data is null, emit an error state
          emit(ClubManagementError('Club does not exist'));
        }
      } else {
        // If club snapshot does not exist, emit an error state
        emit(ClubManagementError('Club does not exist'));
      }
    } else {
      // If createdClubId is null or empty, emit an error state
      emit(ClubManagementError('No club ID available'));
    }
  }

  Future<List<Player>> fetchMembersData(List<String> memberIds) async {
    List<Player> members = [];
    for (String memberId in memberIds) {
      final memberSnapshot = await FirebaseFirestore.instance
          .collection('players')
          .doc(memberId)
          .get();

      if (memberSnapshot.exists) {
        Player member = Player.fromSnapshot(memberSnapshot);
        members.add(member);
      } else {
        print("Member not found for memberId: $memberId"); // Add debug print
      }
    }
    return members;
  }
}
