// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/models/single_match.dart'; // Replace with your model
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/methodes/firebase_methodes.dart';
import '../../../core/utils/widgets/single_match_card copy.dart';
import '../../../generated/l10n.dart';
import '../../../models/club.dart';
import '../../../models/player.dart'; // Replace with your model

class VerticalCarouselSlider extends StatelessWidget {
  final List<SingleMatch> matches;
  final String tournamentId;

  VerticalCarouselSlider(
      {super.key, required this.matches, required this.tournamentId});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double carouselHeight = (screenHeight + screenWidth) * 0.2;

    return CarouselSlider(
      options: CarouselOptions(
        height: matches.isNotEmpty
            ? carouselHeight * 1
            : 0, // Set height based on matches list
        aspectRatio: 16 / 9,
        viewportFraction: .85,
        initialPage: 0,
        enableInfiniteScroll: false,
        enlargeCenterPage: false, scrollDirection: Axis.vertical,
      ),
      items: matches.map((match) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleMatchCard(
            tournamentId: tournamentId,
            match: match,
          ),
        );
      }).toList(),
    );
  }
}

class SingleTournamentsClub extends StatelessWidget {
  const SingleTournamentsClub({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double carouselHeight = (screenHeight + screenWidth) * 0.18;

    Method methodes = Method();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('singleTournaments')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final tournamentDocs = snapshot.data!.docs;

        return FutureBuilder<Player>(
          future: methodes.getCurrentUser(),
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentPlayer = userSnapshot.data!;
            final clubId = currentPlayer.participatedClubId;

            return FutureBuilder<Club>(
              future: methodes.fetchClubData(clubId),
              builder: (context, clubSnapshot) {
                if (!clubSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final clubData = clubSnapshot.data!;
                final singleTournamentsIds = clubData.singleTournamentsIds;

                if (singleTournamentsIds == null ||
                    singleTournamentsIds.isEmpty) {
                  return Container(
                    child: const Text(
                        'No Single Tournaments available for this club.'),
                  );
                }

                final filteredTournamentDocs = tournamentDocs.where((doc) {
                  final tournamentData = doc.data();
                  if (tournamentData == null) {
                    return false;
                  }
                  final tournamentId = doc.id;
                  return singleTournamentsIds.contains(tournamentId);
                }).toList();

                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).SingleTournaments,
                      style: const TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 19,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: filteredTournamentDocs.isNotEmpty
                            ? carouselHeight * 1.3
                            : 0,
                        aspectRatio: 1,
                        viewportFraction: 0.75,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.linear,
                      ),
                      items: filteredTournamentDocs.map((tournamentDoc) {
                        final tournamentData = tournamentDoc.data();
                        if (tournamentData == null) {
                          return Container(
                            child: const Text('sss'),
                          );
                        }

                        return FutureBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                          future: tournamentDoc.reference
                              .collection('singleMatches')
                              .get(),
                          builder: (context, matchesSnapshot) {
                            if (!matchesSnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final tournamentMatches = matchesSnapshot.data!.docs
                                .map((matchDoc) =>
                                    SingleMatch.fromFirestore(matchDoc))
                                .toList();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VerticalCarouselSlider(
                                    tournamentId: tournamentDoc.id,
                                    matches: tournamentMatches),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
