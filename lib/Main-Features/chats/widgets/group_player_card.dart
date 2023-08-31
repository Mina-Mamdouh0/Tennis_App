import 'package:flutter/material.dart';

import '../../../models/player.dart';

class GroupPlayerCard extends StatelessWidget {
  final Player player;

  const GroupPlayerCard({required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center the content vertically
        children: [
          // Player photo
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey, // Customize the border color here
                width: 1.0, // Customize the border width here
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: (player.photoURL != null
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loadin.gif',
                      image: player.photoURL!,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/profile-event.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/internet.png',
                      fit: BoxFit.cover,
                    )),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            // Make the player's name take up the remaining vertical space
            child: Text(
              player.playerName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
