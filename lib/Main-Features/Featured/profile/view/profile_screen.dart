import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/profile/view/widgets/profile_body.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';
import '../../../../core/methodes/firebase_methodes.dart';
import '../../../../core/utils/widgets/app_bar_icon.dart';
import '../../../../core/utils/widgets/opacity_wave.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/player.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final Method method = Method();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF8F8F8),
          child: FutureBuilder<Player>(
            future: method.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the user data to be fetched
                return Container(
                  height: screenHeight,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                // If there was an error while fetching the user data
                return Center(
                  child: Text(S.of(context).error_fetching_club_data),
                );
              } else {
                // If the user data was successfully fetched, show the UI
                final player = snapshot.data!;
                final screenHeight = MediaQuery.of(context).size.height;
                final screenWidth = MediaQuery.of(context).size.width;

                return Column(
                  children: [
                    Stack(
                      children: [
                        AppBarIcon(
                          widgetHeight: screenHeight * .37,
                          svgImage: SvgPicture.asset(
                              'assets/images/create-profile.svg'),
                          text: S.of(context).Your_Profile,
                          player: player,
                        ),
                        OpacityWave(height: screenHeight * 0.377),
                        Positioned(
                          top: 40,
                          left: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: screenWidth * 0.12,
                              height: screenHeight * 0.07,
                              child: IconButton(
                                onPressed: () {
                                  GoRouter.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      player.playerName,
                      style: const TextStyle(
                        color: Color(0xFF1B262C),
                        fontSize: 26,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ProfileBody(player: player),
                    BottomSheetContainer(
                      buttonText: S.of(context).edit,
                      onPressed: () {
                        GoRouter.of(context).push('/editProfile');
                      },
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
