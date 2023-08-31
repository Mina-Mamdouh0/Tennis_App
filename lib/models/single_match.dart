import 'package:cloud_firestore/cloud_firestore.dart';

class SingleMatch {
  String matchId;
  String player1Id;
  String player2Id;
  DateTime startTime;
  DateTime endTime;
  String winner;
  String courtName;

  SingleMatch({
    required this.matchId,
    required this.player1Id,
    required this.player2Id,
    required this.startTime,
    required this.endTime,
    required this.winner,
    required this.courtName,
  });
  // Factory method to create a SingleMatch object from a Firestore document
  factory SingleMatch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SingleMatch(
      matchId: doc.id,
      player1Id: data['player1Id'],
      player2Id: data['player2Id'],
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      winner: data['winner'],
      courtName: data['courtName'],
    );
  }
  // Method to convert a SingleMatch object to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'matchId': matchId,
      'player1Id': player1Id,
      'player2Id': player2Id,
      'startTime': startTime,
      'endTime': endTime,
      'winner': winner,
      'courtName': courtName,
    };
  }
}

// Example of creating a new match within a tournament
Future<void> createMatchInTournament(
    String tournamentId, SingleMatch match) async {
  final tournamentRef = FirebaseFirestore.instance
      .collection('singleTournaments')
      .doc(tournamentId);

  final newMatchRef = tournamentRef.collection('singleMatches').doc();
  await newMatchRef.set(match.toFirestore());
}

// Example of updating match details within a tournament
Future<void> updateMatchInTournament(
    String tournamentId, String matchId, SingleMatch updatedMatch) async {
  final matchRef = FirebaseFirestore.instance
      .collection('singleTournaments')
      .doc(tournamentId)
      .collection('singleMatches')
      .doc(matchId);

  await matchRef.update(updatedMatch.toFirestore());
}

// Example of fetching and displaying matches within a tournament
Future<List<SingleMatch>> getMatchesInTournament(String tournamentId) async {
  final matchesSnapshot = await FirebaseFirestore.instance
      .collection('singleTournaments')
      .doc(tournamentId)
      .collection('singleMatches')
      .get();

  final matchesList = matchesSnapshot.docs
      .map((doc) => SingleMatch.fromFirestore(doc))
      .toList();

  return matchesList;
}
