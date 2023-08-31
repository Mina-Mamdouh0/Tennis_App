import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:tennis_app/core/utils/widgets/photot_player.dart';

import '../../../models/single_match.dart';
import '../../../models/player.dart';
import '../../methodes/firebase_methodes.dart';

class SingleMatchCard extends StatefulWidget {
  final SingleMatch match;
  final String? tournamentId;

  SingleMatchCard({Key? key, required this.match, this.tournamentId})
      : super(key: key);

  @override
  State<SingleMatchCard> createState() => _SingleMatchCardState();
}

class _SingleMatchCardState extends State<SingleMatchCard> {
  Method method = Method();
  String? _selectedWinner1;

  Future<Player?> fetchPlayer(String playerId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> playerSnapshot =
          await FirebaseFirestore.instance
              .collection('players')
              .doc(playerId)
              .get();
      if (playerSnapshot.exists) {
        return Player.fromSnapshot(playerSnapshot);
      }
    } catch (e) {
      print('Error fetching player: $e');
    }
    return null;
  }

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
                title: const Text('Player A Winner'),
                onTap: () async {
                  setState(() {
                    _selectedWinner1 = 'A Winner';
                  });
                  Navigator.of(context).pop();

                  if (widget.tournamentId != null) {
                    await FirebaseFirestore.instance
                        .collection('singleTournaments')
                        .doc(widget.tournamentId)
                        .collection('singleMatches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner': 'A Winner',
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection('single_matches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner': 'A Winner',
                    });
                  }
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player1Id, true);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player2Id, false);
                },
              ),
              ListTile(
                title: const Text('Player B Winner'),
                onTap: () async {
                  setState(() {
                    _selectedWinner1 = 'B Winner';
                  });
                  Navigator.of(context).pop();

                  if (widget.tournamentId != null) {
                    await FirebaseFirestore.instance
                        .collection('singleTournaments')
                        .doc(widget.tournamentId)
                        .collection('singleMatches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner': 'B Winner',
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection('single_matches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner': 'B Winner',
                    });
                  }

                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player1Id, true);
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
                  Navigator.of(context).pop();

                  if (widget.tournamentId != null) {
                    await FirebaseFirestore.instance
                        .collection('singleTournaments')
                        .doc(widget.tournamentId)
                        .collection('singleMatches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner': 'Draw',
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection('single_matches')
                        .doc(widget.match.matchId)
                        .update({
                      'winner': 'Draw',
                    });
                  }
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player1Id, true);
                  await method.updateMatchPlayedAndTotalWins(
                      widget.match.player2Id, true);
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
      future: Future.wait([
        fetchPlayer(widget.match.player1Id),
        fetchPlayer(widget.match.player2Id)
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.length < 2) {
          return const Text('Error loading player data');
        } else {
          final player1 = snapshot.data![0]!;
          final player2 = snapshot.data![1]!;

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
                color: Color(0xFFF3ADAB),
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
                            const Text("Player A",
                                style: TextStyle(
                                  color: Color(0xFF2A2A2A),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 10),
                            PhotoPlayer(url: player1.photoURL!),
                            const SizedBox(height: 7),
                            Text(
                              player1.playerName,
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
                              _selectedWinner1 ?? widget.match.winner,
                              style: const TextStyle(
                                color: Color(0xFF00344E),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset('assets/images/versus.png'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Player B",
                                style: TextStyle(
                                  color: Color(0xFF2A2A2A),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 10),
                            PhotoPlayer(url: player2.photoURL!),
                            const SizedBox(height: 7),
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
                        ), // Display player2's name
                      ],
                    ),
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
                  ) // Display formatted time and date
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
