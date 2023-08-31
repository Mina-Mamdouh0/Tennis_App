import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/choose_club/widgets/card_details.dart';
import 'package:tennis_app/Main-Features/Featured/choose_club/widgets/join_cancel_button.dart';
import 'package:tennis_app/Main-Features/Featured/choose_club/widgets/static_rating_bar.dart';
import 'package:tennis_app/Main-Features/Featured/choose_club/widgets/wave_clipper_widget.dart';
import 'package:tennis_app/models/club.dart';

import '../../../constants.dart';
import '../../../core/utils/widgets/opacity_wave.dart';
import '../../../generated/l10n.dart';

class ChooseClubItem extends StatelessWidget {
  const ChooseClubItem(
      {super.key,
      required this.club,
      this.onJoinPressed,
      this.onCancelPressed});
  final Club club;
  final VoidCallback? onJoinPressed;
  final VoidCallback? onCancelPressed;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight, // Set a fixed height for the container
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  WaveClipperScreenChooseClub(
                    widgetHeight: screenHeight * .4,
                    svgImage: SvgPicture.asset('assets/images/choose-club.svg'),
                    text: S.of(context).joinClub,
                  ),
                  OpacityWave(height: screenHeight * 0.407),
                ],
              ),
              SizedBox(
                height: screenHeight * .005,
              ),
              Text(
                club.clubName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: screenHeight * .007,
              ),
              StaticRatingBar(rating: club.rate),
              SizedBox(
                height: screenHeight * .007,
              ),
              SizedBox(
                width: screenWidth * .4,
                child: Text(
                  club.address,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF6D6D6D),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .007,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardDetails(
                      svgPath: 'assets/images/members.svg',
                      value: club.memberIds.length.toString(),
                      label: S.of(context).totalMembers,
                      color: const Color(0x87FFA372),
                    ),
                    SizedBox(
                      width: screenWidth * .08,
                    ),
                    CardDetails(
                      svgPath: 'assets/images/matches.svg',
                      value: club.matchPlayed.toString(),
                      label: S.of(context).matchPlayed,
                      color: const Color(0x84ED6663),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardDetails(
                      svgPath: 'assets/images/wins.svg',
                      value: club.totalWins.toString(),
                      label: S.of(context).totalWins,
                      color: const Color(0x8294D3D3),
                    ),
                    SizedBox(
                      width: screenWidth * .08,
                    ),
                    CardDetails(
                      svgPath: 'assets/images/courts.svg',
                      value: club.courtsNum.toString(),
                      label: S.of(context).courtsOwn,
                      color: const Color(0x8294B6D3),
                    ),
                  ],
                ),
              ),
              ChooseClubButtons(
                buttonText: S.of(context).join,
                join: () {
                  onJoinPressed!();
                  GoRouter.of(context).replace('/home');
                },
                color: kPrimaryColor,
                cancel: () {
                  onCancelPressed!();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
