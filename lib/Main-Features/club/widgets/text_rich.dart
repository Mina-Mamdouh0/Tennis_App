import 'package:flutter/material.dart';

class MyTextRich extends StatelessWidget {
  const MyTextRich({Key? key, required this.text1, required this.text2})
      : super(key: key);
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double fontSize1 = (screenWidth + screenHeight) * 0.012;
    final double fontSize2 = (screenWidth + screenHeight) * 0.01;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(
              color: const Color(0xFF00344E),
              fontSize: fontSize1,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(
            text: ': ',
            style: TextStyle(
              color: Color(0xFF00344E),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(
              color: const Color(0xFF6D6D6D),
              fontSize: fontSize2,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
