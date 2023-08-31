import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerInfo extends StatelessWidget {
  final String imagePath;
  final String name;
  final String clubName;
  final String svgImagePath;

  const PlayerInfo({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.clubName,
    required this.svgImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double itemWidth = screenWidth * 0.3;
    final double itemHeight = screenHeight * .2;
    final double imageHeight = (screenHeight + screenWidth) * 0.05;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: itemWidth,
      height: itemHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(imageHeight),
            child: Container(
              height: imageHeight,
              width: imageHeight,
              child: imagePath.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loadin.gif',
                      image: imagePath,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        // Show the placeholder image on error
                        return Image.asset(
                          'assets/images/internet.png',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/profile-event.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(height: itemHeight * 0.03),
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: itemHeight * 0.09,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: itemHeight * 0.03),
          Text(
            clubName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6D6D6D),
              fontSize: itemHeight * 0.06,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: itemHeight * 0.03),
          SvgPicture.asset(
            svgImagePath,
            width: screenWidth * 0.15,
            height: screenHeight * 0.043,
          ),
        ],
      ),
    );
  }
}
