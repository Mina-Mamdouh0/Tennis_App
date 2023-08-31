import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/Main-Features/Featured/localization/widgets/waveClipperScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../core/utils/assets.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../generated/l10n.dart';
import '../../../main.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  int selectedFlagIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/deutsch.svg',
      'assets/images/US.svg',
      'assets/images/Espanola.svg',
    ];

    final List<String> languages = [
      'Deutsch',
      'English',
      'Española',
    ];

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> generateImageTiles() {
      return images.map((e) {
        final bool isSelected = images.indexOf(e) == selectedFlagIndex;
        return Container(
          width: 100,
          decoration: isSelected
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                )
              : null,
          child: Opacity(
            opacity: isSelected ? 1.0 : 0.5,
            child: Container(
              decoration: isSelected
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 7),
                    )
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 25),
                    ),
              child: SizedBox(
                child: SvgPicture.asset(
                  e,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }).toList();
    }

    final List<Widget> imageTiles = generateImageTiles();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WaveClipperScreen(svgPicture: AssetsData.translate),
            const Text(
              'Select Your Language',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, vertical: screenWidth * 0.04),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    initialPage: 1,
                    viewportFraction: 0.33,
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedFlagIndex = index;
                      });
                    },
                    aspectRatio: 16 / 9,
                  ),
                  items: imageTiles,
                ),
              ),
            ),
            Container(
              width: 120,
              height: screenHeight * 0.04,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.25, color: Color(0xFF0D5FC3)),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.025,
                  ),
                  SvgPicture.asset('assets/images/check.svg',
                      height: screenHeight * 0.017),
                  SizedBox(
                    width: screenWidth * 0.0375,
                  ),
                  Text(
                    languages[selectedFlagIndex],
                    style: TextStyle(
                      color: const Color(0xFF0F4C81),
                      fontSize: screenHeight * 0.018,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01175,
            ),
            Text(
              'Swipe to change language',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6499999761581421),
                fontSize: screenHeight * 0.0165,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            BottomSheetContainer(
              buttonText: S.of(context).next,
              onPressed: () async {
                // Perform the desired action with the selected flag
                switch (selectedFlagIndex) {
                  case 0:
                    MyApp.setLocale(context, const Locale('de'));
                    break;
                  case 1:
                    MyApp.setLocale(context, const Locale('en'));
                    break;
                  case 2:
                    MyApp.setLocale(context, const Locale('es'));
                    break;
                }
                final prefs = await SharedPreferences.getInstance();
                final showHome = prefs.getBool('showHome') ?? false;

                if (showHome) {
                  // Navigate to the home view
                  GoRouter.of(context).replace('/home');
                } else {
                  // Navigate to the onboarding screen
                  GoRouter.of(context).replace('/onboarding');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
