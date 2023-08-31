import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/club_managment/view/managment_screen.dart';
import 'package:tennis_app/Main-Features/Featured/roles/create_role/view/widgets/rights_selector.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';
import 'package:tennis_app/core/utils/widgets/pop_app_bar.dart';
import '../../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/player.dart';
import 'package:intl/intl.dart';

import '../../../../../models/roles.dart';
import '../../../create_event/view/widgets/player_level.dart';
import '../../../roles/assign_person/service/club_roles_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import the connectivity_plus plugin

class PlayerScreen extends StatefulWidget {
  final Player player;

  const PlayerScreen({required this.player, Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final TextEditingController memberNameController = TextEditingController();
  late List<String> selectedRole;
  late List<String> roleNames;
  late final ClubRolesService clubRolesService;
  bool _isLoading = false; // Add a variable to track loading state
  bool hasInternet =
      true; // Add a boolean variable to track internet connectivity
  double _currentSkillLevel = 5.0; // Default value for skill level

  @override
  void initState() {
    super.initState();
    selectedRole = []; // Initialize selectedRole as an empty list
    roleNames = [];
    clubRolesService = ClubRolesService();
    loadClubRoles();
    checkInternetConnectivity();
    fetchRoleNames();
    _currentSkillLevel = widget.player.skillLevel.isNotEmpty
        ? double.parse(widget.player.skillLevel)
        : 5.0; // Set the current skill level as default
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternet = false;
      });
    } else {
      setState(() {
        hasInternet = true;
      });
    }
  }

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
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

  Future<void> removePlayerFromClub(String playerId) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final DocumentSnapshot<Map<String, dynamic>> admin =
            await FirebaseFirestore.instance
                .collection('players')
                .doc(currentUser.uid)
                .get();
        final data = admin.data();
        final String clubId = data!['participatedClubId'] as String? ?? '';

        final DocumentReference<Map<String, dynamic>> clubReference =
            FirebaseFirestore.instance.collection('clubs').doc(clubId);

        final clubSnapshot = await clubReference.get();
        final clubData = clubSnapshot.data();
        if (clubData != null) {
          final List<String> memberIds =
              List<String>.from(clubData['memberIds'] ?? []);
          if (memberIds.contains(playerId)) {
            memberIds.remove(playerId);
            await clubReference.update({'memberIds': memberIds});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(S.of(context).Player_removed_from_the_club)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text(S.of(context).Player_is_not_a_member_of_the_club)),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).Club_data_not_found)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).User_not_logged_in)),
        );
      }
    } catch (e) {
      print('Error removing player from club: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(S.of(context).Error_assigning_roles_Please_try_again_later),
        ),
      );
    }
  }

  void _assignRole() async {
    final String memberName = widget.player.playerName;
    final double level = context.read<SliderCubit>().state;
    final String skillLevel = level.round().toString();

    if (memberName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).Please_enter_the_member_name)),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(S.of(context).Player_not_found_with_the_given_name)),
          );
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
          final String participatedClubId =
              data['participatedClubId'] as String? ?? '';
          final List<String> roleIds =
              await clubRolesService.fetchRoleIdsByNames(selectedRole);

          if (selectedRole.isEmpty) {
            // Update only skill level if no roles are selected
            final Map<String, dynamic> updatedPlayerData = {
              'skillLevel': skillLevel,
            };
            await playerSnapshot.reference.update(updatedPlayerData);
          } else {
            final String roleIdsString = roleIds.join(',');
            final Map<String, String> clubRoles = {
              participatedClubId: roleIdsString
            };

            final Map<String, dynamic> updatedPlayerData = {
              'clubRoles': clubRoles,
              'skillLevel': skillLevel,
            };
            await playerSnapshot.reference.update(updatedPlayerData);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).Roles_assigned_successfully)),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerScreen(player: widget.player),
            ),
          );
          GoRouter.of(context).push('/management');
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
            content: Text(
                S.of(context).Error_assigning_roles_Please_try_again_later)),
      );
    } finally {
      setState(() {
        _isLoading =
            false; // Set loading state to false after the operation is done
      });
    }
  }

  Future<List<String>> getRolesFromClubRoles(
      Map<String, String> clubRoles) async {
    List<String> roles = [];

    // Fetch the role names from role IDs in clubRoles
    for (var roleValue in clubRoles.values) {
      final roleIds = roleValue.split(',');
      final List<Role> fetchedRoles =
          await clubRolesService.fetchRolesByIds(roleIds);

      // Extract role names from the fetched roles
      final List<String> roleNames =
          fetchedRoles.map((role) => role.name).toList();
      roles.addAll(roleNames);
    }

    return roles;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    SliderCubit sliderCubit = SliderCubit(defaultValue: _currentSkillLevel);

    return BlocBuilder<SliderCubit, double>(
      builder: (context, state) {
        double currentSkillLevel = state;

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
                  text: S.of(context).Management,
                  suffixIconPath: '',
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: (screenHeight + screenWidth) * 0.025,
                          right: (screenHeight + screenWidth) * 0.025,
                          top: (screenHeight + screenWidth) * 0.05),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: (screenHeight + screenWidth) * 0.06,
                          ),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0x440D5FC3)),
                              borderRadius: BorderRadius.circular(31),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  widget.player.playerName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).Skill_level,
                                      style: const TextStyle(
                                        color: Color(0xFF15324F),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.player.skillLevel,
                                      style: const TextStyle(
                                        color: Color(0xFF6D6D6D),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).Membership,
                                      style: const TextStyle(
                                        color: Color(0xFF15324F),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.player.clubRoles['membership'] ??
                                          S.of(context).Clear,
                                      style: const TextStyle(
                                        color: Color(0xFF6D6D6D),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).Player_Type,
                                      style: const TextStyle(
                                        color: Color(0xFF15324F),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.player.playerType,
                                      style: const TextStyle(
                                        color: Color(0xFF6D6D6D),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).Date,
                                      style: const TextStyle(
                                        color: Color(0xFF15324F),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('MMM d, yyyy')
                                          .format(widget.player.birthDate),
                                      style: const TextStyle(
                                        color: Color(0xFF6D6D6D),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).Role,
                                      style: const TextStyle(
                                        color: Color(0xFF15324F),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    FutureBuilder<List<String>>(
                                      future: widget.player.clubRoles.isNotEmpty
                                          ? getRolesFromClubRoles(
                                              widget.player.clubRoles)
                                          : Future.value([]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          final List<String> roleNames =
                                              snapshot.data ?? [];
                                          return Text(
                                            roleNames.isNotEmpty
                                                ? roleNames.join(', ')
                                                : S
                                                    .of(context)
                                                    .No_Role_Assigned,
                                            style: const TextStyle(
                                              color: Color(0xFF6D6D6D),
                                              fontSize: 18,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center, // Center the photo
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                (screenHeight + screenWidth) * 0.08 / 3),
                            child: Container(
                              height: (screenHeight + screenWidth) * 0.1,
                              width: (screenHeight + screenWidth) * 0.08,
                              child: widget.player.photoURL != ''
                                  ? Image.network(
                                      widget.player.photoURL!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/profileimage.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .025,
                ),
                Text(
                  S.of(context).Assign_Role,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ), //call the function here
                Padding(
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
                SizedBox(
                  height: screenHeight * .025,
                ),
                Text(
                  S.of(context).Assign_Player_Skill_Level,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                RangeSliderWithTooltip(
                  text1: '',
                  text2: '',
                  skillLevel: double.tryParse(widget.player.skillLevel),
                  onSkillLevelChanged: (newValue) {
                    setState(() {
                      _currentSkillLevel = newValue;
                      sliderCubit.setSliderValue(newValue);
                    });
                  },
                ),

                GestureDetector(
                  onTap: () async {
                    await removePlayerFromClub(widget.player.playerId);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManagementScreen(),
                      ),
                    );
                  },
                  child: Text(
                    S.of(context).Remove_Member,
                    style: TextStyle(
                      color: Color(0xFF0D5FC3),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: Future.delayed(
                        Duration.zero), // Create a delayed Future
                    builder: (context, snapshot) {
                      // Show the circular progress indicator if _isLoading is true
                      if (_isLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        // Show the "Assign Role" button otherwise
                        return BottomSheetContainer(
                          buttonText: S.of(context).Update_Player,
                          onPressed: _assignRole,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
