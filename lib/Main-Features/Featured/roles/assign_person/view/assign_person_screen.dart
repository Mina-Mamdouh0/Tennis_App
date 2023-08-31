import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Main-Features/Featured/roles/assign_person/view/widgets/member_name.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';
import 'package:tennis_app/core/utils/widgets/pop_app_bar.dart';

import '../../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/roles.dart';
import '../../create_role/view/widgets/rights_selector.dart';
import '../service/club_roles_service.dart';

class AssignPerson extends StatefulWidget {
  AssignPerson({Key? key}) : super(key: key);

  @override
  State<AssignPerson> createState() => _AssignPersonState();
}

class _AssignPersonState extends State<AssignPerson> {
  final TextEditingController memberNameController = TextEditingController();
  late List<String> selectedRole;
  late List<String> roleNames;
  late final ClubRolesService clubRolesService;

  @override
  void initState() {
    super.initState();
    selectedRole = []; // Initialize selectedRole as an empty list
    roleNames = [];
    clubRolesService = ClubRolesService();
    loadClubRoles();
    fetchRoleNames();
  }

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  bool _isLoading = false; // Add a variable to track loading state

  void _assignRole() async {
    final String memberName = memberNameController.text.trim();
    if (memberName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).Please_enter_the_member_name)),
      );
      return;
    }
    if (selectedRole.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).Please_select_at_least_one_role)),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true; // Set loading state to true
      });
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final ClubRolesService clubRolesService = ClubRolesService();
        final String? playerId =
            await clubRolesService.getPlayerIdByName(memberName);
        if (playerId == null) {
          // Show error message if player not found with the given name
          return;
        }
        final DocumentSnapshot<Map<String, dynamic>> playerSnapshot =
            await FirebaseFirestore.instance
                .collection('players')
                .doc(playerId)
                .get();
        final DocumentSnapshot<Map<String, dynamic>> admin =
            await FirebaseFirestore.instance
                .collection('players')
                .doc(currentUser.uid)
                .get();
        final data = admin.data();
        if (data != null) {
          final String createdClubId =
              data['participatedClubId'] as String? ?? '';
          final List<String> roleIds =
              await clubRolesService.fetchRoleIdsByNames(selectedRole);

          // Join the roleIds list into a single string using a delimiter (e.g., comma)
          final String roleIdsString = roleIds.join(',');

          // Create a map of clubRoles with the joined roleIds string
          final Map<String, String> clubRoles = {createdClubId: roleIdsString};

          // Update the player document with the new roles
          await playerSnapshot.reference.update({'clubRoles': clubRoles});

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).Roles_assigned_successfully)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).Player_data_not_found)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).User_not_logged_in)),
        );
      }
    } catch (e) {
      print('Error assigning roles: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(S.of(context).Error_assigning_roles_Please_try_again_later),
        ),
      );
    } finally {
      setState(() {
        _isLoading =
            false; // Set loading state to false after the operation is done
      });
    }
  }

  Future<void> loadClubRoles() async {
    try {
      final userId = getCurrentUserId();
      final playerSnapshot = await FirebaseFirestore.instance
          .collection('players')
          .doc(userId)
          .get();
      final playerData = playerSnapshot.data();
      if (playerData != null) {
        setState(() {});
      }
    } catch (e) {
      // Handle errors if necessary
      print('Error loading club roles: $e');
    }
  }

  Future<void> fetchRoleNames() async {
    try {
      final roleNamesList = await clubRolesService.fetchRoleNames();
      setState(() {
        roleNames.addAll(roleNamesList);
      });
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching role names: $e');
    }
  }

  void updateRoleWithSelectedRole(List<String> roles) {
    setState(() {
      selectedRole = roles;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: const Color(0xFFF8F8F8),
        child: Column(
          children: [
            PoPAppBarWave(
              prefixIcon: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              text: S.of(context).Assign_Person,
              suffixIconPath: '',
            ),
            Text(
              S.of(context).Select_Person,
              style: const TextStyle(
                color: Color(0xFF616161),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * .03),
            MembersName(
              controller: memberNameController,
            ),
            SizedBox(height: screenHeight * .05),
            Text(
              S.of(context).Assign_Roles,
              style: const TextStyle(
                color: Color(0xFF616161),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: RightSelector(
                  selectedWords: selectedRole,
                  onSelectedWordsChanged: (words) {
                    updateRoleWithSelectedRole(words);
                  },
                  words: roleNames, // Use the fetched role names here
                ),
              ),
            ),
            // Use FutureBuilder to show the circular progress indicator
            FutureBuilder(
              future: Future.delayed(Duration.zero), // Create a delayed Future
              builder: (context, snapshot) {
                // Show the circular progress indicator if _isLoading is true
                if (_isLoading) {
                  return const CircularProgressIndicator();
                } else {
                  // Show the "Assign Role" button otherwise
                  return BottomSheetContainer(
                    buttonText: S.of(context).Assign_Role,
                    onPressed: _assignRole,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
