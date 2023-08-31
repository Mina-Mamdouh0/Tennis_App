import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/Match.dart';
import '../widgets/match_item.dart';
import '../widgets/openent_item.dart';

class PeopleRequirement extends StatelessWidget {
  PeopleRequirement({super.key, required this.match});
  final FindMatch match;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xF8F8F8F8),
          child: Column(
            children: [
              AppBarWaveHome(
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
                text: S.of(context).Find_Match,
                suffixIconPath: '',
              ),
              Text(
                S.of(context).Your_Requirements,
                style: const TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * .02),
              MatchItem(match: match),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Text(
                  S.of(context).People_Requirements,
                  style: const TextStyle(
                    color: Color(0xFF313131),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('matches')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final matches = snapshot.data!.docs
                      .map((doc) => FindMatch.fromSnapshot(doc))
                      .where((match) =>
                          match.isActive) // Filter only active matches
                      .toList();

                  // Sort matches based on your criteria here
                  matches.sort((a, b) {
                    // Example: Sort by preferredPlayingTime (highest priority), then dob, then address, then playerType (lowest priority)
                    int preferredPlayingTimeComparison = a.preferredPlayingTime
                        .compareTo(b.preferredPlayingTime);
                    if (preferredPlayingTimeComparison != 0) {
                      // If preferredPlayingTimeComparison is not zero, i.e., a and b have different preferredPlayingTime
                      return preferredPlayingTimeComparison;
                    }

                    // If preferredPlayingTimeComparison is zero, a and b have the same preferredPlayingTime, so compare dob
                    int dobComparison = a.dob.compareTo(b.dob);
                    if (dobComparison != 0) {
                      // If dobComparison is not zero, i.e., a and b have different dob
                      return dobComparison;
                    }

                    // If dobComparison is zero, a and b have the same dob, so compare address
                    int addressComparison = a.address.compareTo(b.address);
                    if (addressComparison != 0) {
                      // If addressComparison is not zero, i.e., a and b have different addresses
                      return addressComparison;
                    }

                    // If addressComparison is zero, a and b have the same address, so check playerType
                    int playerTypeComparison =
                        a.playerType.compareTo(b.playerType);
                    if (playerTypeComparison == 0) {
                      // If playerTypeComparison is zero, a and b have the same playerType, prioritize a before b
                      return -1;
                    }

                    // If playerTypeComparison is not zero, prioritize the normal comparison
                    return playerTypeComparison;
                  });

                  // Reverse the matches list before passing it to ListView
                  final reversedMatches = List.of(matches.reversed);
                  final filteredMatches = reversedMatches
                      .where((m) => m.matchId != match.matchId)
                      .toList();

                  if (filteredMatches.isEmpty) {
                    // If there are no matches available, show the text
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              S.of(context).No_matches_available_now,
                              style: const TextStyle(
                                color: Color(0xFF313131),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredMatches.length,
                    itemBuilder: (context, index) {
                      final opponent = filteredMatches[index];
                      return OpponentItem(
                        match: match,
                        opponent: opponent,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
