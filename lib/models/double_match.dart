import 'package:cloud_firestore/cloud_firestore.dart';

class DoubleMatch {
  String matchId;
  String player1Id;
  String player2Id;
  String player3Id;
  String player4Id;
  DateTime startTime;
  DateTime endTime;
  String winner1;
  String winner2;
  String courtName;

  DoubleMatch({
    required this.matchId,
    required this.player1Id,
    required this.player2Id,
    required this.player3Id,
    required this.player4Id,
    required this.startTime,
    required this.endTime,
    required this.winner1,
    required this.winner2,
    required this.courtName,
  });

  // Factory method to create a DoubleMatch object from a Firestore document
  factory DoubleMatch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return DoubleMatch(
      matchId: doc.id,
      player1Id: data['player1Id'],
      player2Id: data['player2Id'],
      player3Id: data['player3Id'],
      player4Id: data['player4Id'],
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      winner1: data['winner1'],
      winner2: data['winner2'],
      courtName: data['courtName'],
    );
  }

  // Method to convert a DoubleMatch object to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'matchId': matchId,
      'player1Id': player1Id,
      'player2Id': player2Id,
      'player3Id': player3Id,
      'player4Id': player4Id,
      'startTime': startTime,
      'endTime': endTime,
      'winner1': winner1,
      'winner2': winner2,
      'courtName': courtName,
    };
  }
}
