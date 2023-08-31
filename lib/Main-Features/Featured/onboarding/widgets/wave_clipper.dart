import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/widgets/clipper.dart';

class WaveClipperScreen extends StatelessWidget {
  const WaveClipperScreen({super.key, required this.svgPicture});
  final String svgPicture;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * .67,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Container(
              decoration: const BoxDecoration(),
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.black,
                  height: screenHeight * 0.59,
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.8,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/onboarding.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                height: screenHeight * 0.58,
              ),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Container(
              decoration: const BoxDecoration(),
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.black,
                  height: screenHeight * 0.58,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.32,
            top: screenHeight * 0.53,
            child: Align(
              child: SizedBox(
                width: screenHeight * 0.15,
                height: screenHeight * 0.15,
                child: SvgPicture.asset(svgPicture),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
