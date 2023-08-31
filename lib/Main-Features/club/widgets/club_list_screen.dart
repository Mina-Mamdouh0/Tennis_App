import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/methodes/firebase_methodes.dart';
import '../../../models/club.dart';
import '../../../models/player.dart';
import 'club_info.dart';

class ClubListScreen extends StatelessWidget {
  const ClubListScreen({super.key});

  Future<List<Club>> fetchClubs() async {
    // Fetch clubs from Firestore collection
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('clubs').get();

    // Convert querySnapshot documents to Club objects
    List<Club> clubs = querySnapshot.docs
        .map((doc) =>
            Club.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();

    return clubs;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      child: Column(
        children: [
          Text(
            'Choose a club',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Club>>(
              future: fetchClubs(), // Fetch club data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching clubs.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No clubs available.'));
                } else {
                  // Display clubs using ListView.builder
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () async {
                            Method method = new Method();
                            Player currentPlayer =
                                await method.getCurrentUser();

                            GoRouter.of(context).push('/home');
                            await FirebaseFirestore.instance
                                .collection('players')
                                .doc(currentPlayer.playerId)
                                .update({
                              'participatedClubId': snapshot.data![index].clubId
                            });
                            final clubId = snapshot.data![index].clubId;

                            final clubRef = FirebaseFirestore.instance
                                .collection('clubs')
                                .doc(clubId);

                            FirebaseFirestore.instance
                                .runTransaction((transaction) async {
                              DocumentSnapshot<Map<String, dynamic>>
                                  clubSnapshot = await transaction.get(clubRef);

                              if (clubSnapshot.exists) {
                                List<String> memberIds = List<String>.from(
                                    clubSnapshot.data()?['memberIds'] ?? []);
                                if (!memberIds
                                    .contains(currentPlayer.playerId)) {
                                  memberIds.add(currentPlayer.playerId);
                                  transaction.update(
                                      clubRef, {'memberIds': memberIds});
                                }
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClubInfo(clubData: snapshot.data![index]),
                          ));
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
