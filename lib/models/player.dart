import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_app/models/single_match.dart';

class Player {
  final String playerId;
  final String? photoURL;
  final String playerName;
  final String playerLevel;
  final int matchPlayed;
  final int totalWins;
  final String skillLevel;
  final List<String> eventIds;
  final String gender;
  final DateTime birthDate;
  final String preferredPlayingTime;
  final String playerType;
  final String phoneNumber;
  final Map<String, String> clubRoles;
  final String participatedClubId;
  final List<String> clubInvitationsIds;
  final List<Map<String, dynamic>> matches;
  bool isInvitationSent = false;
  final List<String> reversedCourtsIds;
  final List<String> chatIds;
  final List<String> singleMatchesIds;
  final List<String> doubleMatchesIds;
  final List<String> singleTournamentsIds;
  final List<String> doubleTournamentsIds;

  Player({
    required this.playerId,
    required this.playerName,
    required this.photoURL,
    required this.playerLevel,
    required this.matchPlayed,
    required this.totalWins,
    required this.skillLevel,
    required this.eventIds,
    required this.gender,
    required this.birthDate,
    required this.clubRoles,
    required this.preferredPlayingTime,
    required this.playerType,
    required this.phoneNumber,
    required this.participatedClubId,
    required this.clubInvitationsIds,
    required this.chatIds,
    required this.reversedCourtsIds,
    required this.matches,
    required this.singleMatchesIds,
    required this.doubleMatchesIds,
    required this.singleTournamentsIds,
    required this.doubleTournamentsIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'playerName': playerName,
      'photoURL': photoURL,
      'playerLevel': playerLevel,
      'matchPlayed': matchPlayed,
      'totalWins': totalWins,
      'skillLevel': skillLevel,
      'eventIds': eventIds,
      'gender': gender,
      'birthDate': birthDate,
      'preferredPlayingTime': preferredPlayingTime,
      'playerType': playerType,
      'clubInvitationsIds': clubInvitationsIds,
      'phoneNumber': phoneNumber,
      'clubRoles': clubRoles,
      'reversedCourtsIds': reversedCourtsIds,
      'matchId': matches,
      'participatedClubId': participatedClubId,
      'chatIds': chatIds,
      'singleMatchesIds': singleMatchesIds,
      'doubleMatchesIds': doubleMatchesIds,
      'singleTournamentsIds': singleTournamentsIds,
      'doubleTournamentsIds': doubleTournamentsIds,
    };
  }

  factory Player.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw ArgumentError("Invalid data for Player from DocumentSnapshot");
    }

    return Player(
      playerId: snapshot.id,
      playerName: data['playerName'] as String? ?? '',
      photoURL: data['photoURL'] as String?,
      playerLevel: data['playerLevel'] as String? ?? '0',
      matchPlayed: data['matchPlayed'] as int? ?? 0,
      totalWins: data['totalWins'] as int? ?? 0,
      skillLevel: data['skillLevel'] as String? ?? '0',
      eventIds: List<String>.from(data['eventIds'] ?? []),
      gender: data['gender'] as String? ?? '',
      birthDate: (data['birthDate'] as Timestamp).toDate(),
      preferredPlayingTime: data['preferredPlayingTime'] as String? ?? '',
      playerType: data['playerType'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      clubRoles: Map<String, String>.from(data['clubRoles'] ?? {}),
      participatedClubId: data['participatedClubId'] as String? ?? '',
      clubInvitationsIds: List<String>.from(data['clubInvitationsIds'] ?? []),
      matches: List<Map<String, dynamic>>.from(data['matchId'] ?? []),
      reversedCourtsIds: List<String>.from(data['reversedCourtsIds'] ?? []),
      chatIds: List<String>.from(data['chatIds'] ?? []),
      singleMatchesIds: List<String>.from(data['singleMatchesIds'] ?? []),
      doubleMatchesIds: List<String>.from(data['doubleMatchesIds'] ?? []),
      singleTournamentsIds:
          List<String>.from(data['singleTournamentsIds'] ?? []),
      doubleTournamentsIds:
          List<String>.from(data['doubleTournamentsIds'] ?? []),
    );
  }
  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      playerId: map['playerId'] as String? ?? '',
      playerName: map['playerName'] as String? ?? '',
      photoURL: map['photoURL'] as String?,
      playerLevel: map['playerLevel'] as String? ?? '0',
      matchPlayed: map['matchPlayed'] as int? ?? 0,
      totalWins: map['totalWins'] as int? ?? 0,
      skillLevel: map['skillLevel'] as String? ?? '0',
      eventIds: List<String>.from(map['eventIds'] ?? []),
      gender: map['gender'] as String? ?? '',
      birthDate: (map['birthDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      preferredPlayingTime: map['preferredPlayingTime'] as String? ?? '',
      playerType: map['playerType'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      clubRoles: Map<String, String>.from(map['clubRoles'] ?? {}),
      participatedClubId: map['participatedClubId'] as String? ?? '',
      clubInvitationsIds: List<String>.from(map['clubInvitationsIds'] ?? []),
      chatIds: List<String>.from(map['chatIds'] ?? []),
      reversedCourtsIds: List<String>.from(map['reversedCourtsIds'] ?? []),
      matches: List<Map<String, dynamic>>.from(map['matchId'] ?? []),
      singleMatchesIds: List<String>.from(map['singleMatchesIds'] ?? []),
      doubleMatchesIds: List<String>.from(map['doubleMatchesIds'] ?? []),
      singleTournamentsIds:
          List<String>.from(map['singleTournamentsIds'] ?? []),
      doubleTournamentsIds:
          List<String>.from(map['doubleTournamentsIds'] ?? []),
    );
  }
  Future<void> addMatchIdToPlayer(SingleMatch match) async {
    try {
      final playerRef =
          FirebaseFirestore.instance.collection('players').doc(playerId);

      // Check if the player's ID matches with player1 or player2 in the match
      if (match.player1Id == playerId || match.player2Id == playerId) {
        final matchId = match.matchId; // Get the ID of the match
        final updatedMatches = [
          ...singleMatchesIds,
          matchId
        ]; // Add the match ID to the list
        print("pls" + matchId);
        // Update the player's document with the updated matches list
        await playerRef.update({'singleMatchesIds': updatedMatches});

        // You can also update the specific list (e.g., singleMatchesIds or doubleMatchesIds)
        // based on the match type or other criteria if needed.
      }
    } catch (e) {
      print('Error adding match ID to player: $e');
    }
  }
}
