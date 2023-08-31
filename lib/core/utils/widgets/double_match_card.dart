import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:tennis_app/core/utils/widgets/photot_player.dart';
import 'package:tennis_app/models/double_match.dart';
import '../../../models/player.dart';
import '../../methodes/firebase_methodes.dart';

class DoubleMatchCard extends StatefulWidget {
  final DoubleMatch match;
  final String? tournamentId;
  const DoubleMatchCard({Key? key, required this.match, this.tournamentId})
      : super(key: key);

  @override
  State<DoubleMatchCard> createState() => _DoubleMatchCardState();
}

class _DoubleMatchCardState extends State<DoubleMatchCard> {
  Method method = Method();

  Future<List<Player?>> fetchPlayers(List<String> playerIds) async {
    List<Player?> players = [];
    Stream<DocumentSnapshot<Map<String, dynamic>>> getMatchStream() {
      return FirebaseFirestore.instance
          .collection('doubleTournaments')
          .doc(widget.tournamentId)
          .collection('doubleMatches')
          .doc(widget.match.matchId)
          .snapshots();
    }

    try {
      for (String playerId in playerIds) {
        DocumentSnapshot<Map<String, dynamic>> playerSnapshot =
            await FirebaseFirestore.instance
                .collection('players')
                .doc(playerId)
                .get();
        if (playerSnapshot.exists) {
          players.add(Player.fromSnapshot(playerSnapshot));
        } else {
          players.add(null);
        }
      }
    } catch (e) {
      print('Error fetching players: $e');
    }
    return players;
  }

  String? _selectedWinner1;

  Future<void> _showWinnerDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Winners'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Team A Winner'),
                onTap: () async {
                  setState(() {
                    _selectedWinner1 = 'Team A Winner';
                  });
                  GoRouter.of(context).pop();

                  if (widget.tournamentId != null) {
                    await FirebaseFirestore.instance
                        .collection('doubleTournaments')
                        .doc(widget.tournamentId)
                        .collection('doubleMatches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner1': 'Team A Winner',
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection('double_matches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner1': 'Team A Winner',
                    });
                  }
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player1Id, true);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player2Id, true);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player3Id, false);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player4Id, false);
                },
              ),
              ListTile(
                title: const Text('Team B Winner'),
                onTap: () async {
                  setState(() {
                    _selectedWinner1 = 'Team B Winner';
                  });
                  GoRouter.of(context).pop();

                  if (widget.tournamentId != null) {
                    await FirebaseFirestore.instance
                        .collection('doubleTournaments')
                        .doc(widget.tournamentId)
                        .collection('doubleMatches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner1': 'Team B Winner',
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection('double_matches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner1': 'Team B Winner',
                    });
                  }
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player3Id, true);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player4Id, true);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player1Id, false);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player2Id, false);
                },
              ),
              ListTile(
                title: const Text('Draw'),
                onTap: () async {
                  setState(() {
                    _selectedWinner1 = 'Draw';
                  });
                  GoRouter.of(context).pop();

                  if (widget.tournamentId != null) {
                    await FirebaseFirestore.instance
                        .collection('doubleTournaments')
                        .doc(widget.tournamentId)
                        .collection('doubleMatches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner1': 'Draw',
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection('double_matches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner1': 'Draw',
                    });
                  }
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player1Id, false);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player2Id, false);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player3Id, false);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player4Id, false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player?>>(
      future: fetchPlayers([
        widget.match.player1Id,
        widget.match.player2Id,
        widget.match.player3Id,
        widget.match.player4Id
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.length < 4) {
          return const Text('Error loading player data');
        } else {
          final player1 = snapshot.data![0];
          final player2 = snapshot.data![1];
          final player3 = snapshot.data![2];
          final player4 = snapshot.data![3];

          // Format date and time
          final formattedTime =
              DateFormat('hh:mm a').format(widget.match.startTime);
          final formattedDate =
              DateFormat('dd/MM/yyyy').format(widget.match.startTime);

          return GestureDetector(
            onTap: () async {
              bool hasRight = await method.doesPlayerHaveRight('Enter Results');
              if (hasRight) {
                _showWinnerDialog();
              }
            },
            child: Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFFCCBB1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(31),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text("Team A",
                                style: TextStyle(
                                  color: Color(0xFF2A2A2A),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 10),
                            PhotoPlayer(url: player1!.photoURL!),
                            const SizedBox(height: 5),
                            Text(
                              player1.playerName,
                              style: const TextStyle(
                                color: Color(0xFF2A2A2A),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 15),
                            PhotoPlayer(url: player2!.photoURL!),
                            const SizedBox(height: 5),
                            Text(
                              player2.playerName,
                              style: const TextStyle(
                                color: Color(0xFF2A2A2A),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ), // Display player1's name
                        Column(
                          children: [
                            Text(
                              _selectedWinner1 ?? widget.match.winner1,
                              style: const TextStyle(
                                color: Color(0xFF00344E),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset('assets/images/versus.png'),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '$formattedTime\n$formattedDate',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF00344E),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Team B",
                                style: TextStyle(
                                  color: Color(0xFF2A2A2A),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 10),
                            PhotoPlayer(url: player3!.photoURL!),
                            const SizedBox(height: 5),
                            Text(
                              player3.playerName,
                              style: const TextStyle(
                                color: Color(0xFF2A2A2A),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 15),
                            PhotoPlayer(url: player4!.photoURL!),
                            const SizedBox(height: 5),
                            Text(
                              player4.playerName,
                              style: const TextStyle(
                                color: Color(0xFF2A2A2A),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
