import 'package:cloud_firestore/cloud_firestore.dart';

class SingleTournament {
  String id;
  String name;
  bool isDoubles;

  SingleTournament({
    required this.id,
    required this.name,
    required this.isDoubles,
  });

  // Factory method to create a Tournament object from a Firestore document
  factory SingleTournament.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SingleTournament(
      id: doc.id,
      name: data['name'],
      isDoubles: data['isDoubles'],
    );
  }

  // Method to convert a Tournament object to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'isDoubles': isDoubles,
    };
  }
}
