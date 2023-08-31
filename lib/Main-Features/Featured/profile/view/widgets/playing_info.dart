import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_app/Main-Features/Featured/choose_club/widgets/card_details.dart';
import 'package:tennis_app/generated/l10n.dart';
import 'package:tennis_app/models/player.dart';
import 'package:tennis_app/models/groups.dart'; // Import your GroupChats model

class PlayingInfo extends StatefulWidget {
  const PlayingInfo({super.key, required this.player});
  final Player player;

  @override
  _PlayingInfoState createState() => _PlayingInfoState();
}

class _PlayingInfoState extends State<PlayingInfo> {
  int clubRanking = -1; // Initialize with -1 as a default value

  @override
  void initState() {
    super.initState();
    fetchClubRanking();
  }

  void fetchClubRanking() async {
    int ranking = await getPlayerOrderInClub(
      widget.player.participatedClubId,
      widget.player.playerId,
    );

    setState(() {
      clubRanking = ranking;
    });
  }

  Future<int> getPlayerOrderInClub(String clubId, String userId) async {
    try {
      // Fetch club data
      DocumentSnapshot<Map<String, dynamic>> clubSnapshot =
          await FirebaseFirestore.instance
              .collection('clubs')
              .doc(clubId)
              .get();
      Map<String, dynamic> clubData = clubSnapshot.data() ?? {};

      List<String> memberIds = List<String>.from(clubData['memberIds'] ?? []);
      int playerOrder = -1;

      // Fetch player data for all members
      List<Player> clubMembers = await Future.wait(
        memberIds.map((memberId) async {
          DocumentSnapshot<Map<String, dynamic>> playerSnapshot =
              await FirebaseFirestore.instance
                  .collection('players')
                  .doc(memberId)
                  .get();
          return Player.fromSnapshot(playerSnapshot);
        }),
      );

      // Sort players based on totalWins
      clubMembers.sort((a, b) => b.totalWins.compareTo(a.totalWins));

      // Find the index of the specific player
      for (int i = 0; i < clubMembers.length; i++) {
        if (clubMembers[i].playerId == userId) {
          playerOrder = i + 1; // Adding 1 to make it 1-based index
          break;
        }
      }

      return playerOrder;
    } catch (error) {
      print('Error fetching club data: $error');
      return -1; // Return -1 to indicate an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardDetails(
              color: Color(0x30ED6663),
              label: '${S.of(context).Matched_Played} ',
              svgPath: 'assets/images/courts.svg',
              value: widget.player.matchPlayed.toString(),
            ),
            CardDetails(
              color: Color.fromARGB(112, 148, 211, 211),
              label: S.of(context).totalWins,
              svgPath: 'assets/images/wins.svg',
              value: widget.player.totalWins.toString(),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardDetails(
              color: Color(0x3094B6D3),
              label: S.of(context).Skill_level,
              svgPath: 'assets/images/matches.svg',
              value: widget.player.skillLevel.isNotEmpty
                  ? widget.player.skillLevel.toString()
                  : "0",
            ),
            CardDetails(
              color: Color.fromARGB(108, 252, 179, 140),
              label: S.of(context).In_Club_Ranking,
              svgPath: 'assets/images/members.svg',
              value: clubRanking != -1 ? clubRanking.toString() : '_',
            )
          ],
        )
      ],
    );
  }
}
