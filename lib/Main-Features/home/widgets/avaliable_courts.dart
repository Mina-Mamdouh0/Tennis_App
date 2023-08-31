import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/utils/widgets/no_data_text.dart';

import '../../../core/utils/widgets/app_bar_wave.dart';
import '../../../core/utils/widgets/button_home.dart';
import '../../../core/utils/widgets/court_item.dart';
import '../../../generated/l10n.dart';
import '../../../models/player.dart';
import '../../../models/court.dart'; // Import the Court class

class ReversedCourts extends StatefulWidget {
  const ReversedCourts({Key? key}) : super(key: key);

  @override
  State<ReversedCourts> createState() => _ReversedCourtsState();
}

class _ReversedCourtsState extends State<ReversedCourts> {
  int selectedPageIndex = 0;
  final CarouselController _carouselController = CarouselController();
  List<String> reversedCourtsIds = []; // List to store reversed court IDs

  @override
  void initState() {
    super.initState();
    _fetchReversedCourts(); // Fetch reversed courts when the widget initializes
  }

  // Fetch the player data from Firestore and extract reversedCourtsIds
  void _fetchReversedCourts() async {
    try {
      // Fetch the current user's player data from Firestore
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('No user is currently signed in.');
        return;
      }

      String currentUserId = currentUser.uid;

      DocumentSnapshot<Map<String, dynamic>> playerSnapshot =
          await FirebaseFirestore.instance
              .collection('players')
              .doc(currentUserId)
              .get();

      if (!playerSnapshot.exists) {
        print('Player document does not exist for current user.');
        return;
      }

      // Create a Player instance from the snapshot data
      Player currentPlayer = Player.fromSnapshot(playerSnapshot);

      // Get the reversedCourtsIds from the Player instance
      reversedCourtsIds = currentPlayer.reversedCourtsIds;

      // Update the carousel with the fetched data
      setState(() {});
    } catch (error) {
      print('Error fetching reversed courts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double carouselHeight = (screenHeight + screenWidth) * 0.15;

    return Column(
      children: [
        // Conditionally render the CarouselSlider or "No courts" message
        reversedCourtsIds.isNotEmpty
            ? CarouselSlider(
                options: CarouselOptions(
                  height: carouselHeight,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, _) {
                    setState(() {
                      selectedPageIndex = index;
                    });
                  },
                ),
                carouselController: _carouselController,
                items: reversedCourtsIds.map((courtId) {
                  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('courts')
                        .doc(courtId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error fetching court data');
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final courtData = snapshot.data?.data();
                      if (courtData == null) {
                        return const Text('No court data available');
                      }

                      // Create a Court instance from the snapshot data
                      final Court court = Court.fromSnapshot(snapshot.data!);

                      // Build the carousel item using the CourtItem widget
                      return CourtItem(court: court);
                    },
                  );
                }).toList(),
              )
            : Center(
                child: NoData(
                  text: S.of(context).No_Reversed_Courts,
                  height: screenHeight * .15,
                  width: screenWidth * .8,
                  buttonText: S.of(context).Click_to_Reverse_Court,
                  onPressed: () {
                    GoRouter.of(context).push('/findCourt');
                  },
                ),
              ),

        buildPageIndicator(
            reversedCourtsIds.length), // Add the smooth page indicator
      ],
    );
  }

  Widget buildPageIndicator(int itemCount) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final bool isSelected = selectedPageIndex == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 11 : 9,
            height: isSelected ? 11 : 9,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.011),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
