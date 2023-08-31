import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../generated/l10n.dart';
import '../../../models/club.dart';
import 'choose_club_item.dart';

class ClubInvitationsPage extends StatefulWidget {
  @override
  _ClubInvitationsPageState createState() => _ClubInvitationsPageState();
}

class _ClubInvitationsPageState extends State<ClubInvitationsPage> {
  String? currentUserId;
  final _pageController = PageController();
  List<String> clubInvitationsIds = []; // Declare as an instance variable
  Map<String, dynamic>? playerData; // Declare playerData here

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  // Method to get the current user ID
  void _getCurrentUserId() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });
    }
  }

// Method to join a club and add the clubId to the participatedClubId field for the player
  void _joinClub(String clubId) {
    final playerRef =
        FirebaseFirestore.instance.collection('players').doc(currentUserId);

    // Fetch the player document to get the current data
    playerRef.get().then((playerSnapshot) {
      if (playerSnapshot.exists) {
        // Update the player's document with the new clubId in the participatedClubId field
        playerRef.update({'participatedClubId': clubId}).then((_) {
          print('Joined club successfully!');

          // Add the current userId to the clubMembersIds list in the club document
          final clubRef =
              FirebaseFirestore.instance.collection('clubs').doc(clubId);
          clubRef.update({
            'memberIds': FieldValue.arrayUnion([currentUserId])
          }).then((_) {
            print('Updated clubMembersIds successfully!');
          }).catchError((error) {
            print('Error updating clubMembersIds: $error');
          });
        }).catchError((error) {
          print('Error updating player document: $error');
        });
      }
      _removeInvitation(clubId);
    }).catchError((error) {
      print('Error fetching player document: $error');
    });
  }

  // Method to handle the removal of the club invitation ID
  void _removeInvitation(String clubId) {
    final playerRef =
        FirebaseFirestore.instance.collection('players').doc(currentUserId);
    setState(() {
      clubInvitationsIds.remove(clubId);
    });

    // Update the clubInvitationsIds field in Firestore
    playerRef.update({'clubInvitationsIds': clubInvitationsIds});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentUserId == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('players')
                  .doc(currentUserId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return Center(
                      child: Text(S.of(context).No_player_data_available));
                }

                final playerData = snapshot.data!.data();
                if (playerData == null) {
                  return Center(
                      child: Text(S.of(context).No_player_data_available));
                }

                clubInvitationsIds =
                    List<String>.from(playerData['clubInvitationsIds'] ?? []);

                return FutureBuilder<List<Club>>(
                  future: fetchClubs(clubInvitationsIds),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return Center(
                          child: Text(S.of(context).No_player_data_available));
                    }

                    final clubs = snapshot.data!;
                    if (clubs.isEmpty) {
                      // Trigger navigation to '/home' route from the parent widget
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        GoRouter.of(context).go('/home');
                      });
                      // Return an empty container since you need to return a Widget from the builder
                      return Container();
                    }

                    return Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: clubs.length,
                          itemBuilder: (context, index) {
                            final club = clubs[index];
                            return ChooseClubItem(
                              club: club,
                              onJoinPressed: () => _joinClub(club.clubId),
                              onCancelPressed: () =>
                                  _removeInvitation(club.clubId),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: clubs.length,
                            effect: const ExpandingDotsEffect(
                              dotColor: Colors.grey,
                              activeDotColor: Colors.blue,
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 10,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }

  Future<List<Club>> fetchClubs(List<String> clubIds) async {
    final List<Club> clubs = [];

    for (final clubId in clubIds) {
      final clubSnapshot = await FirebaseFirestore.instance
          .collection('clubs')
          .doc(clubId)
          .get();
      if (clubSnapshot.exists) {
        final club = Club.fromSnapshot(clubSnapshot);
        clubs.add(club);
      }
    }

    return clubs;
  }
}
