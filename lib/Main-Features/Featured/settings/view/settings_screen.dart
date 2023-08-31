import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';

import '../../../../core/utils/widgets/opacity_wave.dart';
import '../../../menu/widgets/button_menu.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF8F8F8),
          child: Column(
            children: [
              Stack(
                children: [
                  // AppBarIcon(
                  //   widgetHeight: screenHeight * .32,
                  //   svgImage: SvgPicture.asset('assets/images/setting.svg'),
                  //   text: 'Settings',
                  // ),
                  OpacityWave(height: screenHeight * 0.327),
                  Positioned(
                    top: 40,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: screenWidth * 0.12,
                        height: screenHeight * 0.07,
                        child: IconButton(
                          onPressed: () {
                            print("Press");
                            GoRouter.of(context).push('/menu');
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
              SizedBox(
                height: 30,
              ),
              ButtonMenu(
                imagePath: 'assets/images/setting1.svg',
                buttonText: 'Your Profile',
                onPressed: () {},
              ),
              ButtonMenu(
                imagePath: 'assets/images/setting2.svg',
                buttonText: 'Rate Us',
                onPressed: () {},
              ),
              ButtonMenu(
                imagePath: 'assets/images/Feedbacks.svg',
                buttonText: 'Feedbacks',
                onPressed: () {},
              ),
              ButtonMenu(
                imagePath: 'assets/images/Create-role.svg',
                buttonText: 'Notifications',
                onPressed: () {},
              ),
              ButtonMenu(
                imagePath: 'assets/images/languages.svg',
                buttonText: 'Language',
                onPressed: () {},
              ),
              ButtonMenu(
                imagePath: 'assets/images/help.svg',
                buttonText: 'Help',
                onPressed: () {},
              ),
              BottomSheetContainer(
                buttonText: 'LogOut',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
