import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../models/roles.dart';

class ClubRolesService {
  Future<String?> getPlayerIdByName(String playerName) async {
    try {
      final QuerySnapshot playerSnapshot = await FirebaseFirestore.instance
          .collection('players')
          .where('playerName', isEqualTo: playerName)
          .limit(1)
          .get();

      if (playerSnapshot.docs.isNotEmpty) {
        final QueryDocumentSnapshot<Object?> playerDoc =
            playerSnapshot.docs.first;
        return playerDoc.id;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching player ID: $e');
      return null;
    }
  }

  Future<List<Role>> fetchRolesByIds(List<String> roleIds) async {
    try {
      final rolesSnapshot = await FirebaseFirestore.instance
          .collection('roles')
          .where(FieldPath.documentId, whereIn: roleIds)
          .get();

      final rolesData = rolesSnapshot.docs;
      final List<Role> rolesList =
          rolesData.map((roleDoc) => Role.fromSnapshot(roleDoc)).toList();
      return rolesList;
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching roles data: $e');
      return [];
    }
  }

  Future<List<String>> fetchClubRoles(String clubId) async {
    try {
      final clubDoc = await FirebaseFirestore.instance
          .collection('clubs')
          .doc(clubId)
          .get();
      final clubData = clubDoc.data();
      if (clubData != null) {
        return List<String>.from(clubData['roleIds'] ?? []);
      }
      return [];
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching club roles: $e');
      return [];
    }
  }

  Future<List<String>> fetchRoleIdsByNames(List<String> roleNames) async {
    try {
      final rolesSnapshot = await FirebaseFirestore.instance
          .collection('roles')
          .where('name', whereIn: roleNames)
          .get();
      final roleIds = rolesSnapshot.docs.map((roleDoc) => roleDoc.id).toList();
      return roleIds;
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching role IDs: $e');
      return [];
    }
  }

  Future<List<String>> fetchRoleNames() async {
    try {
      final roleNamesList = <String>[];

      final String playerId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch the player data for the current player using the player ID
      final playerSnapshot = await FirebaseFirestore.instance
          .collection('players')
          .doc(playerId)
          .get();
      final String createdClubId =
          playerSnapshot['participatedClubId'] as String? ?? '';
      final clubSnapshot = await FirebaseFirestore.instance
          .collection('clubs')
          .doc(createdClubId)
          .get();
      final clubData = clubSnapshot.data();
      if (clubData == null) {
        // Handle the case if player data not found
        return roleNamesList;
      }

      // Get the list of role IDs from the player data
      final List<String> roleIds = List<String>.from(clubData['roleIds'] ?? []);

      // Fetch the roles based on the role IDs from the 'roles' collection
      final rolesSnapshot = await FirebaseFirestore.instance
          .collection('roles')
          .where(FieldPath.documentId, whereIn: roleIds)
          .get();
      final rolesData = rolesSnapshot.docs;
      for (final roleDoc in rolesData) {
        final roleData = roleDoc.data();
        final roleName = roleData['name'] as String;
        roleNamesList.add(roleName);
      }
      return roleNamesList;
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching role names for club: $e');
      return [];
    }
  }

  Future<List<String>> fetchRoleIds() async {
    try {
      final roleIdsList = <String>[];
      final rolesSnapshot =
          await FirebaseFirestore.instance.collection('roles').get();
      final rolesData = rolesSnapshot.docs;
      for (final roleDoc in rolesData) {
        final roleId = roleDoc.id;
        roleIdsList.add(roleId);
      }
      return roleIdsList;
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching role IDs: $e');
      return [];
    }
  }
}
