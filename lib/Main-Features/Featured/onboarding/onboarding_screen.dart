import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/Main-Features/Featured/onboarding/widgets/page.dart';

import '../../../core/utils/assets.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../generated/l10n.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: screenHeight * 0.093),
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          children: [
            PageViewScreen(
                controller: controller,
                svgPicture: AssetsData.onboarding1,
                header: S.of(context).onboarding_header1,
                details: S.of(context).onboarding_detail1),
            PageViewScreen(
                controller: controller,
                svgPicture: AssetsData.onboarding2,
                header: S.of(context).onboarding_header2,
                details: S.of(context).onboarding_detail2),
            PageViewScreen(
                controller: controller,
                svgPicture: AssetsData.onboarding3,
                header: S.of(context).onboarding_header3,
                details: S.of(context).onboarding_detail3),
            PageViewScreen(
                controller: controller,
                svgPicture: AssetsData.onboarding4,
                header: S.of(context).onboarding_header4,
                details: S.of(context).onboarding_detail4),
          ],
        ),
      ),
      bottomSheet: BottomSheetContainer(
        buttonText:
            currentPage == 3 ? S.of(context).getStarted : S.of(context).next,
        onPressed: () async {
          if (currentPage < 3) {
            controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('showHome', true);
            GoRouter.of(context).push('/auth');
          }
        },
      ),
    );
  }
}
