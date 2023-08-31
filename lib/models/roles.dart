import 'package:cloud_firestore/cloud_firestore.dart';

class Role {
  final String id;
  final String name;
  final List<String> rights;

  Role({
    required this.id,
    required this.name,
    required this.rights,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rights': rights,
    };
  }

  static Role fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    final rightsList = List<String>.from(data['rights'] ?? []);
    return Role(
      id: snapshot.id,
      name: data['name'] as String,
      rights: rightsList,
    );
  }
}
