import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;

  const HomeButton({
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final containerWidth = screenWidth * 0.4;
    final containerHeight = screenHeight * 0.06;

    final iconSize = containerHeight * 0.5;
    final iconSpacing = screenWidth * 0.022;

    final textFontSize = screenWidth * 0.04;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: ShapeDecoration(
          color: const Color(0x30FFA372),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.25, color: Color(0xFF00344E)),
            borderRadius: BorderRadius.circular(containerHeight / 2),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(containerHeight * 0.2),
          child: Row(
            children: [
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: SvgPicture.asset(
                  imagePath,
                ),
              ),
              SizedBox(
                width: iconSpacing,
              ),
              Container(
                width: 1,
                height: containerHeight * 0.375,
                color: Colors.black38,
              ),
              SizedBox(
                width: iconSpacing,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: Color(0xFF00344E),
                      fontSize: textFontSize,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
