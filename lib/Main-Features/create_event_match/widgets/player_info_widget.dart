import 'package:flutter/material.dart';
import 'package:tennis_app/Main-Features/create_event_match/widgets/player_search_match.dart';

import '../../../models/player.dart';

class PlayerInfoWidget extends StatelessWidget {
  final Player? selectedPlayer;
  final Function(Player) onPlayerSelected;

  PlayerInfoWidget({
    required this.selectedPlayer,
    required this.onPlayerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double itemWidth = screenWidth * 0.3;
    final double itemHeight = screenHeight * .2;

    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(top: 8),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selectedPlayer != null
              ? Column(
                  children: [
                    Container(
                      width: screenHeight * 0.065,
                      height: screenHeight * 0.065,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: (selectedPlayer?.photoURL != ''
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loadin.gif',
                                image: selectedPlayer?.photoURL ??
                                    'assets/images/profile-event.jpg',
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
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
                              )),
                      ),
                    ),
                    SizedBox(height: itemHeight * 0.03),
                    Text(
                      selectedPlayer!.playerName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: itemHeight * 0.09,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: itemHeight * 0.03),
                    Text(
                      selectedPlayer!.gender,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: itemHeight * 0.06,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : Container(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayerSearchMatch(
                    onPlayerSelected: onPlayerSelected,
                  ),
                ),
              );
            },
            icon: Icon(Icons.ads_click),
          ),
        ],
      ),
    );
  }
}
