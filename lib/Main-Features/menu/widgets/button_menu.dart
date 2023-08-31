import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonMenu extends StatelessWidget {
  const ButtonMenu(
      {super.key,
      required this.imagePath,
      required this.buttonText,
      required this.onPressed});
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = screenHeight * 0.06;

    final iconSize = containerHeight * 0.5;
    final iconSpacing = screenWidth * 0.022;

    final textFontSize = screenWidth * 0.04;
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: screenWidth * .85,
          height: screenHeight * .06,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: Color(0x300A557F)),
              borderRadius: BorderRadius.circular(100),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x1E000000),
                blurRadius: 6,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: iconSpacing * 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: SvgPicture.asset(
                    imagePath,
                  ),
                ),
              ),
              SizedBox(
                width: iconSpacing,
              ),
              Container(
                width: .8,
                height: containerHeight * 0.6,
                color: Colors.black12,
              ),
              SizedBox(
                width: iconSpacing * 2,
              ),
              Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: textFontSize,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
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
