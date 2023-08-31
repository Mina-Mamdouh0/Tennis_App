import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';
import 'club_event_item.dart';

class ClubEvents extends StatefulWidget {
  const ClubEvents({Key? key, required this.eventsId}) : super(key: key);
  final List<String> eventsId;
  @override
  State<ClubEvents> createState() => _ClubEventsState();
}

class _ClubEventsState extends State<ClubEvents> {
  int selectedPageIndex = 0;
  final CarouselController _carouselController = CarouselController();
  List<Event> clubEvents = []; // List to store fetched club events

  @override
  void initState() {
    super.initState();
    fetchClubEvents(); // Fetch the club events when the widget is initialized
  }

  void fetchClubEvents() async {
    // Fetch events from Firestore using eventIds in the club collection
    final eventsCollection = FirebaseFirestore.instance.collection('events');
    final List<Event> fetchedEvents = [];
    for (String eventId in widget.eventsId) {
      final eventSnapshot = await eventsCollection.doc(eventId).get();
      final event = Event.fromSnapshot(eventSnapshot);
      fetchedEvents.add(event);
      print(event.clubId);
    }
    setState(() {
      clubEvents = fetchedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double carouselHeight = screenHeight * 0.26;

    return Column(
      children: [
        if (clubEvents.isNotEmpty)
          CarouselSlider(
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
            items: clubEvents.map((event) {
              return ClubEventItem(
                event: event,
                showSetReminder: true,
              );
            }).toList(),
          )
        else
          CarouselSlider(
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
            // Show a single dummy CarouselItem with dummy data
            items: [
              ClubEventItem(
                event: _createDummyEvent(),
                showSetReminder: false,
              )
            ],
          ),
        SizedBox(height: 8),
        buildPageIndicator(clubEvents.isNotEmpty ? clubEvents.length : 1),
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

  // Create a dummy event for the single CarouselItem
  Event _createDummyEvent() {
    return Event(
      eventId: 'dummy_event_id',
      eventType: 'Dummy Event',
      eventStartAt: DateTime.now(),
      eventEndsAt: DateTime.now().add(Duration(hours: 2)),
      eventAddress: 'Dummy Address', clubId: '', courtName: '', eventName: '',
      instructions: '', playerIds: [], playerLevel: 0,
      // Add other properties as needed
    );
  }
}
