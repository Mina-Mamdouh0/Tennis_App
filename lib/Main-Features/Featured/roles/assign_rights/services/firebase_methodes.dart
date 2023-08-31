import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../models/roles.dart';

class AssignRightsService {
  static Future<void> updateRoleOnFirestore(
      BuildContext context, Role role, List<String> selectedRights) async {
    try {
      final updatedRole = Role(
        id: role.id,
        name: role.name,
        rights: selectedRights,
      );

      // Update the role document in Firestore
      await FirebaseFirestore.instance
          .collection('roles')
          .doc(updatedRole.id)
          .update(updatedRole.toJson());

      // Show a success message or navigate to a success screen
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Role Updated'),
          content: const Text('Role rights have been updated successfully.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the previous screen or any other desired screen
                GoRouter.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while updating the role.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
