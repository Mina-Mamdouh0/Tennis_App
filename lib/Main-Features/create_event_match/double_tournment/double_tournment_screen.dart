import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/create_event_match/double_tournment/double_tournment_item.dart';
import '../../../core/methodes/firebase_methodes.dart';
import '../../../core/utils/widgets/double_match_card.dart';
import '../../../core/utils/widgets/pop_app_bar.dart';

import '../../../models/club.dart';
import '../../../models/double_match.dart';
import '../../../models/player.dart';
import '../../../models/single_tournment.dart';

class DoubleTournamentScreen extends StatefulWidget {
  const DoubleTournamentScreen({super.key});

  @override
  _DoubleTournamentScreenState createState() => _DoubleTournamentScreenState();
}

class _DoubleTournamentScreenState extends State<DoubleTournamentScreen> {
  String tournamentId = ''; // Updated to store the generated tournament ID
  List<DoubleMatch> matches = [];

  @override
  void initState() {
    super.initState();
    _createTournament();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PoPAppBarWave(
              prefixIcon: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              text: 'Tournament',
              suffixIconPath: '',
            ),
            Visibility(
              visible:
                  matches.isNotEmpty, // Set visibility based on matches list
              child: CarouselSlider.builder(
                itemCount: matches.length,
                itemBuilder: (context, index, realIndex) {
                  final match = matches[index];
                  return DoubleMatchCard(match: match);
                },
                options: CarouselOptions(
                  height: matches.isNotEmpty
                      ? screenHeight * .25
                      : 0, // Set height based on matches list
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.75,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            MatchInputForm(onSave: _saveMatch),
          ],
        ),
      ),
    );
  }

  Future<void> _createTournament() async {
    final newTournament = SingleTournament(
      name: 'Tournament Name',
      isDoubles: true,
      id: '',
    );

    final tournamentRef = await FirebaseFirestore.instance
        .collection('doubleTournaments')
        .add(newTournament.toFirestore());

    setState(() {
      tournamentId = tournamentRef.id;
    });
  }

  void _saveMatch(DoubleMatch doubleMatch) async {
    final tournamentRef = FirebaseFirestore.instance
        .collection('doubleTournaments')
        .doc(tournamentId);

    final newMatchRef = tournamentRef.collection('doubleMatches').doc();
    await newMatchRef.set(doubleMatch.toFirestore());

    // Update the newMatch object with the generated match ID

    final newMatchRef2 = await FirebaseFirestore.instance
        .collection('double_matches')
        .add(doubleMatch.toFirestore());

    doubleMatch.matchId = newMatchRef2.id;
    final player1Doc = await FirebaseFirestore.instance
        .collection('players')
        .doc(doubleMatch.player1Id)
        .get();
    final player2Doc = await FirebaseFirestore.instance
        .collection('players')
        .doc(doubleMatch.player2Id)
        .get();
    final player3Doc = await FirebaseFirestore.instance
        .collection('players')
        .doc(doubleMatch.player3Id)
        .get();
    final player4Doc = await FirebaseFirestore.instance
        .collection('players')
        .doc(doubleMatch.player4Id)
        .get();

    final player1 = Player.fromSnapshot(player1Doc);
    final player2 = Player.fromSnapshot(player2Doc);
    final player3 = Player.fromSnapshot(player3Doc);
    final player4 = Player.fromSnapshot(player4Doc);

    // Update the players' doubleMatchesIds lists with the new match ID
    player1.doubleMatchesIds.add(doubleMatch.matchId);
    player2.doubleMatchesIds.add(doubleMatch.matchId);
    player3.doubleMatchesIds.add(doubleMatch.matchId);
    player4.doubleMatchesIds.add(doubleMatch.matchId);

    // Update the players' documents with the updated lists
    await player1Doc.reference
        .update({'doubleMatchesIds': player1.doubleMatchesIds});
    await player2Doc.reference
        .update({'doubleMatchesIds': player2.doubleMatchesIds});
    await player3Doc.reference
        .update({'doubleMatchesIds': player3.doubleMatchesIds});
    await player4Doc.reference
        .update({'doubleMatchesIds': player4.doubleMatchesIds});

    Method method = Method();
    Player currentUser = await method.getCurrentUser();
    Club clubData = await method.fetchClubData(currentUser.participatedClubId);
    clubData.doubleTournamentsIds.add(tournamentRef.id);
    await FirebaseFirestore.instance
        .collection('clubs')
        .doc(currentUser.participatedClubId)
        .update({
      'doubleTournamentsIds': clubData.doubleTournamentsIds,
    });

    setState(() {
      matches.add(doubleMatch);
    });
  }
}
