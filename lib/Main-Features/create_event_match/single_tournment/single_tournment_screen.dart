import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/utils/widgets/single_match_card%20copy.dart';
import 'package:tennis_app/Main-Features/create_event_match/single_tournment/single_tournment_item.dart';
import '../../../core/methodes/firebase_methodes.dart';
import '../../../core/utils/widgets/double_match_card.dart';
import '../../../core/utils/widgets/pop_app_bar.dart';

import '../../../models/club.dart';
import '../../../models/player.dart';
import '../../../models/single_match.dart';
import '../../../models/single_tournment.dart';

class SingleTournamentScreen extends StatefulWidget {
  const SingleTournamentScreen({super.key});

  @override
  _SingleTournamentScreenState createState() => _SingleTournamentScreenState();
}

class _SingleTournamentScreenState extends State<SingleTournamentScreen> {
  String tournamentId = ''; // Updated to store the generated tournament ID
  List<SingleMatch> matches = [];

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
                  return SingleMatchCard(match: match);
                },
                options: CarouselOptions(
                  height: matches.isNotEmpty
                      ? screenHeight * .22
                      : 0, // Set height based on matches list
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.6,
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
      isDoubles: false,
      id: '',
    );

    final tournamentRef = await FirebaseFirestore.instance
        .collection('singleTournaments')
        .add(newTournament.toFirestore());

    setState(() {
      tournamentId = tournamentRef.id;
    });
  }

  void _saveMatch(SingleMatch newMatch) async {
    final tournamentRef = FirebaseFirestore.instance
        .collection('singleTournaments')
        .doc(tournamentId);

    final newMatchRef = tournamentRef.collection('singleMatches').doc();
    await newMatchRef.set(newMatch.toFirestore());

    final newMatchRef2 = await FirebaseFirestore.instance
        .collection('single_matches')
        .add(newMatch.toFirestore());

    newMatch.matchId = newMatchRef2.id;

    // Fetch the players based on their IDs
    final player1Doc = await FirebaseFirestore.instance
        .collection('players')
        .doc(newMatch.player1Id)
        .get();
    final player2Doc = await FirebaseFirestore.instance
        .collection('players')
        .doc(newMatch.player2Id)
        .get();

    final player1 = Player.fromSnapshot(player1Doc);
    final player2 = Player.fromSnapshot(player2Doc);

    // Update the players' singleMatchesIds lists with the new match ID
    player1.singleMatchesIds.add(newMatch.matchId);
    player2.singleMatchesIds.add(newMatch.matchId);

    // Update the players' documents with the updated lists
    await player1Doc.reference
        .update({'singleMatchesIds': player1.singleMatchesIds});
    await player2Doc.reference
        .update({'singleMatchesIds': player2.singleMatchesIds});

    Method method = Method();
    Player currentUser = await method.getCurrentUser();
    Club clubData = await method.fetchClubData(currentUser.participatedClubId);
    clubData.singleTournamentsIds.add(tournamentRef.id);
    await FirebaseFirestore.instance
        .collection('clubs')
        .doc(currentUser.participatedClubId)
        .update({
      'singleTournamentsIds': clubData.singleTournamentsIds,
    });

    setState(() {
      matches.add(newMatch);
    });
  }
}
