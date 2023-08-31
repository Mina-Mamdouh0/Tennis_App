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
    final double fontSize1 = (screenWidth + screenHeight) * 0.013;
    final double fontSize2 = (screenWidth + screenHeight) * 0.012;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(
              color: const Color(0xFF00344E),
              fontSize: fontSize1,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: ': ',
            style: TextStyle(
              color: Color(0xFF00344E),
              fontSize: fontSize2,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(
              color: const Color(0xFF6D6D6D),
              fontSize: fontSize2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
