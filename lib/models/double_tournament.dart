import 'double_match.dart';

class DoubleTournament {
  String id;
  String name;
  List<DoubleMatch> doubleMatches;

  DoubleTournament({
    required this.id,
    required this.name,
    required this.doubleMatches,
  });

  // Factory method to create a Tournament object from a Firestore document
  factory DoubleTournament.fromFirestore(Map<String, dynamic> doc) {
    return DoubleTournament(
      id: doc['id'],
      name: doc['name'],
      doubleMatches: List.from(doc['doubleMatches']).map((match) => DoubleMatch.fromFirestore(match)).toList(),
    );
  }

  // Method to convert a Tournament object to a Firestore document
  Map<String, dynamic> toFirestore() {  
    return {
      'id': id,
      'name': name,
      'doubleMatches': doubleMatches.map((match) => match.toFirestore()).toList(),
    };
  }
}
