import 'package:flutter/material.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double itemSize = (screenWidth + screenHeight) * 0.055;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: itemSize,
        height: itemSize,
        decoration: const ShapeDecoration(
          color: Color(0x260D5FC3),
          shape: CircleBorder(),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_downward_outlined, color: Color(0xFF0D5FC3)),
              Text(
                'See all',
                style: TextStyle(
                  color: Color(0xFF0D5FC3),
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
