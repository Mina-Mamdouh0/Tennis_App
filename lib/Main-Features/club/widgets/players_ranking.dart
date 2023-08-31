import 'package:flutter/material.dart';
import 'package:tennis_app/Main-Features/club/widgets/player_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/club.dart';
import '../../../models/player.dart';

class PlayersRanking extends StatefulWidget {
  final String clubId;
  final String clubName;
  const PlayersRanking({Key? key, required this.clubId, required this.clubName})
      : super(key: key);

  @override
  State<PlayersRanking> createState() => _PlayersRankingState();
}

class _PlayersRankingState extends State<PlayersRanking> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<Player>>(
            future: fetchSortedPlayers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while fetching data
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle the error
                return Text('Error: ${snapshot.error}');
              } else {
                // Use the fetched sorted players to build the list
                final List<Player> sortedPlayers = snapshot.data ?? [];
                final List<Widget> playerItems = sortedPlayers.map((player) {
                  final index = sortedPlayers.indexOf(player);
                  String svgImagePath;
                  if (index == 0) {
                    svgImagePath = 'assets/images/first.svg';
                  } else if (index == 1) {
                    svgImagePath = 'assets/images/second.svg';
                  } else {
                    svgImagePath = '';
                  }

                  return Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.04),
                    child: PlayerInfo(
                      imagePath:
                          player.photoURL ?? 'assets/images/profile-image.jpg',
                      name: player.playerName,
                      clubName: widget.clubName,
                      svgImagePath: svgImagePath,
                    ),
                  );
                }).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: playerItems,
                  ),
                );
              }
            },
          ),
          SizedBox(height: screenWidth * 0.04),
          // SeeAll(),
        ],
      ),
    );
  }

  Future<List<Player>> fetchSortedPlayers() async {
    final clubDoc = await FirebaseFirestore.instance
        .collection('clubs')
        .doc(widget.clubId)
        .get();
    final club = Club.fromSnapshot(clubDoc);

    final playerDocs = await FirebaseFirestore.instance
        .collection('players')
        .where('playerId', whereIn: club.memberIds)
        .get();

    final List<Player> players = playerDocs.docs
        .map((playerDoc) => Player.fromSnapshot(playerDoc))
        .toList();
    players.sort((a, b) => b.totalWins
        .compareTo(a.totalWins)); // Sort in descending order of totalWins
    return players;
  }
}
