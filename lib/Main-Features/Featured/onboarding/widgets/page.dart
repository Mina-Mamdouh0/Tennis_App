import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tennis_app/Main-Features/Featured/onboarding/widgets/skip_button.dart';
import 'package:tennis_app/Main-Features/Featured/onboarding/widgets/wave_clipper.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({
    Key? key,
    required this.svgPicture,
    required this.header,
    required this.details,
    required this.controller,
  }) : super(key: key);

  final String svgPicture;
  final String header;
  final String details;
  final PageController controller;

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  // Receive the PageController as a parameter
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.69,
              child: Stack(
                children: [
                  WaveClipperScreen(svgPicture: widget.svgPicture),
                  SkipButton(
                    controller: widget.controller,
                  )
                ],
              ),
            ),
            Text(
              widget.header,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.details,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SmoothPageIndicator(
                controller: widget.controller,
                count: 4,
                effect: const WormEffect(
                  dotWidth: 15,
                  dotHeight: 15,
                  activeDotColor: Colors.black,
                  dotColor: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
