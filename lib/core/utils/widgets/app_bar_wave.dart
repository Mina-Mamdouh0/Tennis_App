import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/methodes/firebase_methodes.dart';

import '../../../models/player.dart';
import 'app_bar_clipper.dart';

class AppBarWaveHome extends StatelessWidget {
  final String text;
  final Widget? prefixIcon; // Make the prefixIcon nullable

  final String suffixIconPath;

  const AppBarWaveHome({
    Key? key,
    required this.text,
    required this.suffixIconPath,
    this.prefixIcon, // Provide a default value of null
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Method method = Method();

    return FutureBuilder<Player>(
      future: method.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: screenHeight * 0.14,
            width: screenWidth,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            height: screenHeight * 0.14,
            width: screenWidth,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final player = snapshot.data!;
          final hasPrefixIcon = prefixIcon != null;

          return Stack(
            children: [
              SizedBox(
                height: screenHeight * 0.14,
                width: screenWidth,
                child: ClipPath(
                  clipper: AppBarClipper(),
                  child: Container(
                    color: const Color.fromARGB(255, 34, 47, 53),
                    padding:
                        const EdgeInsets.only(top: 12, right: 16, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (hasPrefixIcon) // Show prefixIcon if not null
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: screenWidth * 0.12,
                              height: screenHeight * 0.07,
                              child: prefixIcon!,
                            ),
                          )
                        else // Show ClipRRect with player.photoURL otherwise
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).go('/profileScreen');
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: screenHeight * 0.065,
                                height: screenHeight * 0.065,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: (player.photoURL != null
                                        ? FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/loadin.gif',
                                            image: player.photoURL!,
                                            fit: BoxFit.cover,
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/profile-event.jpg',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            'assets/images/internet.png',
                                            fit: BoxFit.cover,
                                          )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Text(
                          text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.22,
                          height: screenHeight * 0.22,
                          child: SvgPicture.asset(
                            suffixIconPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
