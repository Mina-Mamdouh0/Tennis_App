import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../models/Match.dart';
import '../../../../club/widgets/text_rich.dart';
import '../../../../home/widgets/divider.dart';
import 'package:intl/intl.dart';

class MatchItem extends StatefulWidget {
  const MatchItem({super.key, required this.match});
  final FindMatch match;

  @override
  State<MatchItem> createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  bool hasInternet =
      true; // Add a boolean variable to track internet connectivity

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternet = false;
      });
    } else {
      setState(() {
        hasInternet = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = (screenHeight + screenWidth) * 0.08;

    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 10),
      width: screenWidth * .9,
      height: screenHeight * .25,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(31),
        boxShadow: const [
          BoxShadow(
            color: Color(
                0x440D5FC3), // Shadow color with opacity (adjust the alpha value)
            blurRadius: 5.0, // Adjust the blur radius as per your preference
            spreadRadius:
                1.0, // Adjust the spread radius as per your preference
            offset: Offset(0,
                3), // Adjust the offset to control the position of the shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.match
                .playerName, // Access the member's name from the Player object
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          const MyDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(imageHeight / 3),
                    child: Container(
                      height: imageHeight * 1.3,
                      width: imageHeight,
                      child: hasInternet // Check if there's internet connection
                          ? (widget.match.photoURL != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/loadin.gif',
                                  image: widget.match.photoURL!,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    // Show the placeholder image on error
                                    return Image.asset(
                                      'assets/images/profileimage.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/profileimage.png',
                                  fit: BoxFit.cover,
                                ))
                          : Image.asset(
                              'assets/images/loadin.gif',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .005,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextRich(
                    text1: S.of(context).Player_Type,
                    text2: widget.match.playerType,
                  ),
                  SizedBox(height: screenHeight * .01),
                  MyTextRich(
                      text1: S.of(context).Address,
                      text2: widget.match.address),
                  SizedBox(height: screenHeight * .01),
                  MyTextRich(
                    text1: S.of(context).Date_,
                    text2: DateFormat('MMM d, yyyy').format(widget.match.dob),
                  ),
                  SizedBox(height: screenHeight * .01),
                  MyTextRich(
                    text1: S.of(context).Preferred_time_,
                    text2: widget.match.preferredPlayingTime,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
