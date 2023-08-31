// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/core/utils/widgets/double_match_card.dart';
import 'package:tennis_app/models/double_match.dart'; // Replace with your model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_app/models/player.dart'; // Replace with your model
import 'package:tennis_app/models/club.dart';

import '../../../core/methodes/firebase_methodes.dart';
import '../../../generated/l10n.dart'; // Replace with your model

class VerticalCarouselSlider extends StatelessWidget {
  final List<DoubleMatch> matches;
  final String tournamentId;
  const VerticalCarouselSlider(
      {required this.matches, required this.tournamentId});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double carouselHeight = (screenHeight + screenWidth) * 0.21;
    return CarouselSlider(
      options: CarouselOptions(
        height: matches.isNotEmpty ? carouselHeight * 1.1 : 0,
        aspectRatio: 16 / 9,
        viewportFraction: .85,
        initialPage: 0,
        enableInfiniteScroll: false,
        enlargeCenterPage: false,
        scrollDirection: Axis.vertical,
      ),
      items: matches.map((match) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DoubleMatchCard(
            tournamentId: tournamentId,
            match: match,
          ),
        );
      }).toList(),
    );
  }
}

class DoubleTournamentsClub extends StatelessWidget {
  const DoubleTournamentsClub({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double carouselHeight = (screenHeight + screenWidth) * 0.22;
    Method methodes = Method();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('doubleTournaments')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final tournamentDocs = snapshot.data!.docs;

        return FutureBuilder<Player>(
          future: methodes
              .getCurrentUser(), // Replace with your method to fetch the current user
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentPlayer = userSnapshot.data!;
            final clubId = currentPlayer.participatedClubId;

            return FutureBuilder<Club>(
              future: methodes.fetchClubData(
                  clubId), // Replace with your method to fetch club data
              builder: (context, clubSnapshot) {
                if (!clubSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final clubData = clubSnapshot.data!;
                final doubleTournamentsIds = clubData.doubleTournamentsIds;
                print(doubleTournamentsIds);
                if (doubleTournamentsIds.isEmpty) {
                  return Container(
                    child: const Text(
                        'No Double Tournaments available for this club.'),
                  );
                }

                final filteredTournamentDocs = tournamentDocs.where((doc) {
                  final tournamentData = doc.data();
                  if (tournamentData == null) {
                    return false;
                  }
                  final tournamentId =
                      doc.id; // Use doc.id to get the document ID
                  return doubleTournamentsIds.contains(tournamentId);
                }).toList();

                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).DoubleTournaments,
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
                            ? carouselHeight * 1.255
                            : 0, // Set height based on matches list
                        aspectRatio: 1,
                        viewportFraction: 0.75,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true, autoPlayCurve: Curves.linear,
                      ),
                      items: filteredTournamentDocs.map((tournamentDoc) {
                        final tournamentData = tournamentDoc.data();
                        if (tournamentData == null) {
                          return Container(
                            child: const Text('sss'),
                          );
                        }

                        // Fetch the subcollection data for 'doubleMatches'
                        return FutureBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                          future: tournamentDoc.reference
                              .collection('doubleMatches')
                              .get(),
                          builder: (context, matchesSnapshot) {
                            if (!matchesSnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final tournamentMatches = matchesSnapshot.data!.docs
                                .map((matchDoc) =>
                                    DoubleMatch.fromFirestore(matchDoc))
                                .toList();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Use the VerticalCarouselSlider to display matches
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
