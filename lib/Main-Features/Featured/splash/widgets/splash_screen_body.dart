import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/core/utils/assets.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({Key? key}) : super(key: key);

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animationController.forward();

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
            .animate(animationController);

    navigateToHomeOrOnboarding();
  }

  void navigateToHomeOrOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool('showHome') ?? false;

    if (showHome) {
      // Navigate to the home view
      GoRouter.of(context).replace('/home');
    } else {
      // Navigate to the onboarding screen
      GoRouter.of(context).replace('/languages');
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
              'assets/images/background-splash.png'), // Replace with your background image path
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white
                .withOpacity(0.4), // Set the desired opacity value (0.0 to 1.0)
            BlendMode.dstATop,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fontSize = constraints.biggest.height * 0.04;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsData.splashIcon,
                width: screenHeight * 0.15,
                height: screenHeight * 0.15,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              AnimatedBuilder(
                animation: slidingAnimation,
                builder: (context, _) {
                  return SlideTransition(
                    position: slidingAnimation,
                    child: Text(
                      'Match Point',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
