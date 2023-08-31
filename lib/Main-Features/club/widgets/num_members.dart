import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/l10n.dart';

class NumMembers extends StatelessWidget {
  const NumMembers({super.key, required this.num});
  final String num;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double itemSize = (screenHeight + screenWidth);
    return Container(
      width: screenWidth * .7,
      height: screenHeight * .06,
      decoration: ShapeDecoration(
        color: Color(0x87FFA372),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/members.svg',
              width: screenWidth * 0.15,
              height: screenHeight * 0.03,
            ),
            Text(
              S.of(context).totalMembers,
              style: TextStyle(
                color: Colors.black,
                fontSize: itemSize * .012,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              num,
              style: TextStyle(
                color: Color(0xFF00344E),
                fontSize: itemSize * .026,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
