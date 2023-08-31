import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/widgets/clipper.dart';

class WaveClipperScreen extends StatelessWidget {
  const WaveClipperScreen({Key? key, required this.svgPicture})
      : super(key: key);
  final String svgPicture;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.66,
      width: screenWidth,
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
                width: screenWidth,
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
                  width: screenWidth,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.07,
            top: screenHeight * 0.41,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WELCOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .005,
                ),
                const Text(
                  'Let’s gets started',
                  style: TextStyle(
                    color: Color(0xFFDADADA),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.53,
              ),
              Center(
                child: SizedBox(
                  width: screenHeight * 0.1,
                  height: screenHeight * 0.1,
                  child: SvgPicture.asset(svgPicture),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
