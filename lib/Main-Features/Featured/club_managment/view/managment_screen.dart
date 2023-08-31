import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Main-Features/Featured/club_managment/view/screens/invite_members.dart';
import 'package:tennis_app/Main-Features/Featured/club_managment/view/screens/members_list.dart';
import 'package:tennis_app/core/utils/widgets/app_bar_wave.dart';
import 'package:tennis_app/core/utils/widgets/rules_text_field.dart';
import 'package:tennis_app/models/player.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/utils/widgets/custom_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/club.dart';
import '../../../club/widgets/club_info.dart';
import '../../../club/widgets/num_members.dart';
import '../../create_club/view/widgets/Age_restriction.dart';
import '../cubit/club_management_cubit.dart';
import '../cubit/club_management_state.dart';

class ManagementScreen extends StatefulWidget {
  ManagementScreen({Key? key}) : super(key: key);

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  final TextEditingController rulesController = TextEditingController();
  String? createdClubId;
  ClubManagementCubit clubManagementCubit = ClubManagementCubit();

  @override
  void initState() {
    super.initState();
    getCurrentUserClubId();
  }

  Future<void> getCurrentUserClubId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String? currentUserId = user.uid;
      final userSnapshot = await FirebaseFirestore.instance
          .collection('players')
          .doc(currentUserId)
          .get();
      if (userSnapshot.exists) {
        final userData = userSnapshot.data();
        if (userData != null && userData.containsKey('participatedClubId')) {
          createdClubId = userData['participatedClubId'] as String?;
          clubManagementCubit.fetchClubData(createdClubId);
        }
      }
    }
  }

  int mapAgeRestrictionToValue(String ageRestriction) {
    // Map age restriction string to numeric value
    switch (ageRestriction) {
      case "Everyone":
        return 3;
      case "Above 18":
        return 2;
      case "Above 20":
        return 1;
      default:
        return 0; // Set a default numeric value if the ageRestriction doesn't match any case
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<ClubManagementCubit, ClubManagementState>(
        bloc: clubManagementCubit,
        builder: (context, state) {
          if (state is ClubManagementLoading) {
            // Show a loading indicator while fetching data
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClubManagementLoaded) {
            // Club data and members data are loaded, update the UI with the fetched data
            List<Player> members = state.members;
            Club club = state.club; // Get the club data

            return Container(
              color: const Color(0xFFF8F8F8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppBarWaveHome(
                      prefixIcon: IconButton(
                        onPressed: () {
                          GoRouter.of(context).replace('/menu');
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
                    Container(
                        margin: EdgeInsets.only(
                            right: screenWidth * .05,
                            top: screenWidth * .02,
                            left: screenWidth * .05,
                            bottom: screenWidth * .05),
                        child: ClubInfo(
                          clubData: club,
                        )),
                    NumMembers(
                      num: club.memberIds.length.toString(),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * .13,
                          vertical: screenWidth * .035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).Manage_Members,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InviteMember(club: club),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).Invite_Members,
                              style: TextStyle(
                                color: Color(0xFF0D5FC3),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    HorizontalListView(memberNames: members),
                    SizedBox(height: screenHeight * .03),
                    Text(
                      S.of(context).Rules_and_regulations,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RulesInputText(
                      header: S.of(context).Set_the_rules_for_members,
                      body: club.rulesAndRegulations,
                      controller: rulesController,
                    ),
                    SizedBox(height: screenHeight * .03),
                    Text(
                      S.of(context).Age_restriction,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const AgeRestrictionWidget(),
                    SizedBox(height: screenHeight * .015),
                    BottomSheetContainer(
                      buttonText: S.of(context).Set,
                      onPressed: () async {
                        // Update the club data with new rules and age restriction
                        String newRules = rulesController.text;
                        int selectedChoice = context
                            .read<AgeRestrictionCubit>()
                            .getSelectedValue();

                        // If newRules is empty, use the current club rulesAndRegulations
                        if (newRules.isEmpty) {
                          newRules = club.rulesAndRegulations;
                        }

                        // If the selectedChoice is 0, use the current club ageRestriction
                        if (selectedChoice == 0) {
                          selectedChoice =
                              mapAgeRestrictionToValue(club.ageRestriction);
                        }
                        // Update Firestore document for the club
                        await FirebaseFirestore.instance
                            .collection('clubs')
                            .doc(createdClubId)
                            .update({
                          'rulesAndRegulations': newRules,
                          'ageRestriction':
                              mapValueToAgeRestriction(selectedChoice),
                        });

                        // Optionally, you can show a confirmation message to the user
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(S.of(context).Update_Player)));

                        // Refetch the club data to update the UI with the latest changes
                        clubManagementCubit.fetchClubData(createdClubId);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ClubManagementError) {
            // Error occurred while fetching data, show an error message
            return Center(child: Text(state.errorMessage));
          } else {
            // Show an initial state UI
            return Center(child: Text(S.of(context).Loading));
          }
        },
      ),
    );
  }

  String mapValueToAgeRestriction(int value) {
    // Map numeric value to age restriction string
    switch (value) {
      case 1:
        return "Above 20";
      case 2:
        return "Above 18";
      case 3:
        return "Everyone";
      default:
        return ""; // Set a default value if the value doesn't match any case
    }
  }

  @override
  void dispose() {
    clubManagementCubit.close();
    super.dispose();
  }
}
