import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/widgets/clipper.dart';
import '../../../../generated/l10n.dart';

class AppBarWave extends StatelessWidget {
  const AppBarWave({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.33,
          width: screenWidth,
          child: ClipPath(
            clipper: WaveClipper(),
            child: Container(
              color: const Color(0xFF1B262C),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.04,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).Create_Your_Profile,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.05,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: screenWidth * 0.35,
                    height: screenHeight * 0.25,
                    child: SvgPicture.asset(
                      'assets/images/create-profile.svg',
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
}
