import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../models/club.dart';
import '../../../../../models/player.dart';
import '../../../../../models/roles.dart';

Future<Player> getPlayerData(String playerId) async {
  final playerDoc = await FirebaseFirestore.instance
      .collection('players')
      .doc(playerId)
      .get();
  return Player.fromSnapshot(playerDoc);
}

Future<Club> getClubData(String clubId) async {
  final clubDoc =
      await FirebaseFirestore.instance.collection('clubs').doc(clubId).get();
  return Club.fromSnapshot(clubDoc);
}

Future<List<Role>> getRoles(List<String> roleIds) async {
  const batchSize = 10;
  final List<List<String>> batches = [
    for (int i = 0; i < roleIds.length; i += batchSize)
      roleIds.sublist(
          i, i + batchSize > roleIds.length ? roleIds.length : i + batchSize)
  ];

  final List<QuerySnapshot> querySnapshots = await Future.wait(
    batches.map(
      (batch) => FirebaseFirestore.instance
          .collection('roles')
          .where(FieldPath.documentId, whereIn: batch)
          .get(),
    ),
  );

  final List<Role> roles = [];
  for (var querySnapshot in querySnapshots) {
    roles.addAll(querySnapshot.docs.map((doc) =>
        Role.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>)));
  }

  return roles;
}
