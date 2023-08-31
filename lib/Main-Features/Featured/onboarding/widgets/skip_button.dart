import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const count = 4;

    return Positioned(
      left: screenHeight * 0.02,
      top: screenHeight * 0.044,
      child: Container(
        width: screenHeight * 0.08,
        height: screenHeight * 0.04,
        decoration: BoxDecoration(
          color: const Color(0x44d9d9d9),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: TextButton(
            onPressed: () {
              controller.animateToPage(
                count - 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              S.of(context).skip,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
