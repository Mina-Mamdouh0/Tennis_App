import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/widgets/clipper.dart';
import '../../../models/player.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    Key? key,
    required this.widgetHeight,
    required this.text,
    required this.svgImage,
    required this.player,
  }) : super(key: key);

  final double widgetHeight;
  final String text;
  final SvgPicture svgImage;
  final Player player;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 0.13;
    print(player.photoURL);
    return Stack(
      children: [
        SizedBox(
          height: widgetHeight,
          width: screenWidth,
          child: ClipPath(
            clipper: WaveClipper(),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  child: Container(
                    color: const Color(0xFF1B262C),
                    height: screenHeight * 0.58,
                    width: screenWidth,
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenHeight * 0.04,
                      ),
                      alignment: Alignment.topRight,
                      decoration: const BoxDecoration(),
                      child: SizedBox(
                        height: screenHeight * 0.32,
                        width: screenWidth * 0.45,
                        child: svgImage,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: screenWidth * 0.05,
                  top: screenHeight * 0.17,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: widgetHeight * 1.26,
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Align items to the center vertically
            children: [
              const Spacer(),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageHeight / 5),
                  child: Container(
                    height: imageHeight,
                    width: imageHeight,
                    child: (player.photoURL != ''
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loadin.gif',
                            image: player.photoURL!,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              // Show the placeholder image on error
                              return Image.asset(
                                'assets/images/profileimage.png',
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/profile-event.jpg',
                            fit: BoxFit.cover,
                          )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
