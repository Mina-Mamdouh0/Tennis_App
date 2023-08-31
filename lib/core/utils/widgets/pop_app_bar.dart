import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_bar_clipper.dart';

class PoPAppBarWave extends StatelessWidget {
  final Widget prefixIcon;
  final String text;
  final String suffixIconPath;

  const PoPAppBarWave({
    Key? key,
    required this.prefixIcon,
    required this.text,
    required this.suffixIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.14,
          width: screenWidth,
          child: ClipPath(
            clipper: AppBarClipper(),
            child: Container(
              color: const Color.fromARGB(255, 34, 47, 53),
              padding: const EdgeInsets.only(top: 12, right: 0, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: screenWidth * 0.12,
                      height: screenHeight * 0.07,
                      child: prefixIcon,
                    ),
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.20,
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
}
