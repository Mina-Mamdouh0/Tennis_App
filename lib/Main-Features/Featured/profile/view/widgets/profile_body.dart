import 'package:flutter/material.dart';
import 'package:tennis_app/Main-Features/Featured/profile/view/widgets/personal_info.dart';
import 'package:tennis_app/Main-Features/Featured/profile/view/widgets/player_strength.dart';
import 'package:tennis_app/Main-Features/Featured/profile/view/widgets/playing_info.dart';
import 'package:tennis_app/models/club.dart'; // Replace 'Club' with the correct Club class path

import '../../../../../core/methodes/firebase_methodes.dart';
import '../../../../../core/utils/widgets/no_data_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/player.dart';
import '../../../../club/widgets/club_info.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.player});
  final Player player;
  double parseSkillLevel(String skillLevel) {
    try {
      return double.parse(skillLevel);
    } catch (e) {
      // Return a default value (e.g., 0.0) in case parsing fails
      return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final Method method = Method();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .07),
          child: Column(
            children: [
              PersonalInfo(
                player: player,
              ),
              const SizedBox(height: 20),
              PlayingInfo(
                player: player,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Your Club',
            style: TextStyle(
              color: Color(0xFF313131),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        FutureBuilder<Club>(
          future: method.fetchClubData(player.participatedClubId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return SizedBox(
                width: screenWidth * .8,
                height: screenHeight * .2,
                child: NoData(
                  buttonText: 'Click here to join',
                  text: 'You not participated in any class',
                ),
              );
            } else {
              final clubData = snapshot.data;
              return Container(
                margin: EdgeInsets.only(
                  right: screenWidth * .05,
                  left: screenWidth * .05,
                  bottom: screenWidth * .05,
                ),
                child: clubData != null
                    ? ClubInfo(
                        clubData: clubData,
                      )
                    : NoData(
                        buttonText: 'Click here to join',
                        text: 'You not participated in any class',
                      ), // Show the NoData widget when clubData is null
              );
            }
          },
        ),
        Text(
          S.of(context).Your_Strength,
          style: const TextStyle(
            color: Color(0xFF313131),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        PlayerStrength(
          value: parseSkillLevel(player.skillLevel),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            S
                .of(context)
                .Your_strength_will_be_determined_based_on_your_playing_record_and_your_performance_may_impact_your_strength_rating,
            style: const TextStyle(
              color: Color(0xFF6A6A6A),
              fontSize: 11,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
