import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardDetails extends StatelessWidget {
  final String svgPath;
  final String value;
  final String label;
  final Color color;

  const CardDetails({
    Key? key,
    required this.svgPath,
    required this.value,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final containerWidth = screenWidth * 0.38;
    final containerHeight = screenHeight * 0.14;

    return Container(
      padding: EdgeInsets.all(containerWidth * 0.05),
      width: containerWidth,
      height: containerHeight * 1.05,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(containerHeight * 0.25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            width: containerWidth * 0.24,
            height: containerHeight * 0.3,
          ),
          SizedBox(height: containerHeight * 0.05),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF00344E),
              fontSize: containerHeight * 0.3,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: containerHeight * 0.02),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: containerHeight * 0.1,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
