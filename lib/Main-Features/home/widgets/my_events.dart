import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/widgets/no_data_text.dart';
import '../../../generated/l10n.dart';
import '../../../models/event.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  int selectedPageIndex = 0;
  final CarouselController _carouselController = CarouselController();
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('players')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final playerData = snapshot.data!.data();
          final List<String> eventIds =
              (playerData?['eventIds'] as List<dynamic>?)
                      ?.map((id) => id.toString())
                      .toList() ??
                  [];

          if (eventIds.isEmpty) {
            // Show the NoData widget when the eventIds list is empty
            return NoData(
              text: S.of(context).You_Dont_have_Events,
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * .8,
              buttonText: S.of(context).Register_for_events_on_the_Club_page,
            );
          }

          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.265,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.5,
                  onPageChanged: (index, _) {
                    setState(() {
                      selectedPageIndex = index;
                    });
                  },
                ),
                carouselController: _carouselController,
                items: eventIds.map((eventId) {
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: eventsCollection.doc(eventId).get()
                        as Future<DocumentSnapshot<Map<String, dynamic>>>,
                    builder: (context, eventSnapshot) {
                      if (eventSnapshot.hasData) {
                        final event = Event.fromSnapshot(eventSnapshot.data!);

                        return CarouselItem(
                          selected:
                              selectedPageIndex == eventIds.indexOf(eventId),
                          event: event, // Pass the event object here
                        );
                      } else if (eventSnapshot.hasError) {
                        return Center(
                          child: Text(S.of(context).error_fetching_club_data),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              buildPageIndicator(eventIds.length),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(S.of(context).Error_fetching_player_data),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildPageIndicator(int itemCount) {
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
            margin: const EdgeInsets.symmetric(horizontal: 4),
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

class CarouselItem extends StatelessWidget {
  final bool selected;
  final Event event; // Receive the Event object as a parameter

  const CarouselItem({
    Key? key,
    required this.selected,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double itemWidth = screenWidth * 0.6;
    final double itemHeight = screenHeight * .3;

    final double scaleFactor = selected ? 1.0 : 0.72;

    final Color backgroundColor =
        selected ? const Color(0xFFFCCBB1) : const Color(0xFFF3ADAB);
    print(event.photoURL);
    return Container(
      width: 500,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.079),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              backgroundImage: event.photoURL != null
                  ? NetworkImage(event.photoURL!)
                  : Image.asset('assets/images/profile-event.jpg').image,
              radius: (itemHeight * 0.15) * scaleFactor,
            ),
          ),
          SizedBox(height: itemHeight * 0.03),
          Text(
            event.eventName,
            style: TextStyle(
              color: const Color(0xFF2A2A2A),
              fontSize: itemHeight * 0.06 * scaleFactor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: itemHeight * 0.03),
          Text(
            '${event.eventStartAt.hour}:${event.eventStartAt.minute} \n${event.eventStartAt.day}/${event.eventStartAt.month}/${event.eventStartAt.year}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF00344E),
              fontSize: itemHeight * 0.051 * scaleFactor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: itemHeight * 0.03),
          Container(
            width: itemWidth * 0.7 * scaleFactor,
            decoration: ShapeDecoration(
              color: const Color(0xFF1B262C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.089),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  S.of(context).Register_Done,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: itemHeight * 0.056 * scaleFactor,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
