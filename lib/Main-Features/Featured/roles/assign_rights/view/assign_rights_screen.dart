import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/roles.dart';
import '../../create_role/view/widgets/rights_selector.dart';
import '../services/firebase_methodes.dart'; // Import the RightSelector widget

class AssignRights extends StatefulWidget {
  const AssignRights({super.key, required this.role});
  final Role role;

  @override
  State<AssignRights> createState() => _AssignRightsState();
}

class _AssignRightsState extends State<AssignRights> {
  final TextEditingController roleController = TextEditingController();
  late List<String> selectedRights;

  @override
  void initState() {
    super.initState();
    selectedRights = List.from(widget.role.rights);
  }

  // Function to update the Role with selected rights
  void updateRoleWithSelectedRights(List<String> rights) {
    setState(() {
      selectedRights = rights;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    List<String> words = [
      S.of(context).Send_Invitations,
      S.of(context).Create_Event,
      S.of(context).Create_tennis_courts,
      S.of(context).Create_offers,
      S.of(context).Edit_club,
      S.of(context).Delete_club,
      S.of(context).Edit_members,
      S.of(context).Delete_members,
      S.of(context).Create_Training,
      S.of(context).Set_up_leagues,
      S.of(context).Create_Roles,
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          color: const Color(0xFFF8F8F8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBarWaveHome(
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
                text: '   ${S.of(context).Roles}',
                suffixIconPath: '',
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).Role_Details, // Update the header text
                        style: const TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: screenHeight * .03),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16),
                        child: Container(
                          decoration: ShapeDecoration(
                            color: const Color(0x51FFA372),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.person_add_alt,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.role.name,
                                style: const TextStyle(
                                  color: Color(0xFF15324F),
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .03),
                      Text(
                        S.of(context).You_can_add_more_rights_to_a_role,
                        style: const TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: screenHeight * .03),
                      RightSelector(
                        selectedWords: selectedRights,
                        onSelectedWordsChanged: (words) {
                          // Call the function to update the Role with selected rights
                          updateRoleWithSelectedRights(words);
                        },
                        words: words,
                      ),
                      SizedBox(height: screenHeight * .03),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: const Color(0xFFF8F8F8),
                  child: BottomSheetContainer(
                    buttonText:
                        S.of(context).Update_Role, // Update the button text
                    onPressed: () async {
                      // Call the function to update the Role with selected rights
                      AssignRightsService.updateRoleOnFirestore(
                          context, widget.role, selectedRights);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
