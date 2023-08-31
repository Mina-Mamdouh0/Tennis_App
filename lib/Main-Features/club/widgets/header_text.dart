import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.only(left: screenWidth * .13, bottom: 4),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xB2313131),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }
}
