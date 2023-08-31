import 'package:flutter/material.dart';
import 'package:tennis_app/Main-Features/Featured/club_managment/view/screens/player_screen.dart';
import 'package:tennis_app/Main-Features/Featured/club_managment/view/widgets/text_rich.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/player.dart';
import '../../../../home/widgets/divider.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import the connectivity_plus plugin

class MemberItem extends StatefulWidget {
  final Player member; // Modify the memberName type to Player

  const MemberItem({required this.member, Key? key}) : super(key: key);

  @override
  _MemberItemState createState() => _MemberItemState();
}

class _MemberItemState extends State<MemberItem> {
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
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: screenWidth * .8,
      height: screenHeight * .27,
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
            widget.member
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextRich(
                    text1: S.of(context).Matched_Played,
                    text2: widget.member.matchPlayed.toString(),
                  ),
                  SizedBox(height: screenHeight * .01),
                  MyTextRich(
                    text1: S.of(context).Total_Win,
                    text2: widget.member.totalWins.toString(),
                  ),
                  SizedBox(height: screenHeight * .01),
                  MyTextRich(
                    text1: S.of(context).Player_Type,
                    text2: widget.member.playerType,
                  ),
                  SizedBox(height: screenHeight * .01),
                  MyTextRich(
                    text1: S.of(context).Birth_date_,
                    text2: DateFormat('MMM d, yyyy')
                        .format(widget.member.birthDate),
                  ),
                  SizedBox(height: screenHeight * .01),
                ],
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(imageHeight / 5),
                    child: Container(
                      height: imageHeight,
                      width: imageHeight,
                      child: hasInternet // Check if there's internet connection
                          ? (widget.member.photoURL != ''
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/loadin.gif',
                                  image: widget.member.photoURL!,
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
                  Container(
                    decoration: const ShapeDecoration(
                      color: Color.fromARGB(212, 15, 32, 42),
                      shape: OvalBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.ads_click, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlayerScreen(player: widget.member),
                          ),
                        );
                      },
                    ),
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
