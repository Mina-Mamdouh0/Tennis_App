import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../models/club.dart';
import '../../../../../models/roles.dart';

enum RoleCreationStatus {
  initial,
  loading,
  success,
  error,
}

class RoleCubit extends Cubit<RoleCreationStatus> {
  RoleCubit() : super(RoleCreationStatus.initial);

  Future<void> createRole({
    required TextEditingController roleController,
    required List<String> selectedWords,
    required BuildContext context,
  }) async {
    emit(RoleCreationStatus.loading);

    try {
      if (roleController.text.isNotEmpty) {
        if (selectedWords.isNotEmpty) {
          // Create the role in Firebase
          final role = Role(
            id: '', // Generate an ID or use a predefined one
            name: roleController.text,
            rights: selectedWords,
          );

          late String roleId;

          try {
            final DocumentReference documentRef = await FirebaseFirestore
                .instance
                .collection('roles')
                .add(role.toJson());

            roleId = documentRef.id;
            final roleWithId = Role(
              id: roleId,
              name: role.name,
              rights: role.rights,
            );

            await documentRef.set(roleWithId.toJson());

            // Assuming you have access to the current user's ID and created club ID
            final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

            final DocumentSnapshot playerSnapshot = await FirebaseFirestore
                .instance
                .collection('players')
                .doc(userId)
                .get();
            final playerData = playerSnapshot.data();

            if (playerData != null) {
              final String createdClubId = (playerData
                  as Map<String, dynamic>)['participatedClubId'] as String;
              print(createdClubId);

              final clubId =
                  createdClubId; // Replace this with the actual clubId

              final clubRef =
                  FirebaseFirestore.instance.collection('clubs').doc(clubId);
              final clubSnapshot = await clubRef.get();

              if (clubSnapshot.exists) {
                final club = Club.fromSnapshot(clubSnapshot);

                // Add the roleId to the club's roleIds list
                final updatedRoleIds = List<String>.from(club.roleIds)
                  ..add(roleId);

                // Update the club document with the new roleIds
                await clubRef.update({'roleIds': updatedRoleIds});

                print('Successfully added roleId to the club document');
              } else {
                print('Club document with clubId $clubId does not exist');
              }
            }

            emit(RoleCreationStatus.success);
          } catch (error) {
            // Error creating the role
            print('Error creating role: ${error.toString()}');
            emit(RoleCreationStatus.error);
          }
        } else {
          emit(RoleCreationStatus.error);
        }
      } else {
        emit(RoleCreationStatus.error);
      }
    } catch (error) {
      emit(RoleCreationStatus.error);
    }
  }
}
