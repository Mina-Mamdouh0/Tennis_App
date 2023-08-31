import 'package:cloud_firestore/cloud_firestore.dart';

class Court {
  final String courtId;
  final String courtName;
  final String phoneNumber;
  final DateTime startDate;
  final DateTime endDate;
  final String courtAddress;
  final String photoURL;
  final bool reversed; // New property with default value false

  Court({
    required this.courtId,
    required this.courtName,
    required this.phoneNumber,
    required this.startDate,
    required this.endDate,
    required this.courtAddress,
    required this.photoURL,
    this.reversed = false, // Optional
  });

  Map<String, dynamic> toJson() {
    return {
      'courtId': courtId,
      'courtName': courtName,
      'phoneNumber': phoneNumber,
      'startDate': startDate,
      'endDate': endDate,
      'courtAddress': courtAddress,
      'photoURL': photoURL,
      'reversed': reversed,
    };
  }

  static Court fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Court(
      courtId: snapshot.id,
      courtName: data['courtName'] as String,
      phoneNumber: data['phoneNumber'] as String,
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      courtAddress: data['courtAddress'] as String,
      photoURL: data['photoURL'] as String,
      reversed: data['reversed'] as bool? ??
          false, // Provide a default value of false if 'reversed' is null
    );
  }
}
