import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/widgets/court_item.dart';
import '../../../../models/court.dart';

class AvailableCourts extends StatefulWidget {
  const AvailableCourts({super.key});

  @override
  _AvailableCourtsState createState() => _AvailableCourtsState();
}

class _AvailableCourtsState extends State<AvailableCourts> {
  TextEditingController searchController = TextEditingController();
  List<Court> allCourts = [];
  List<Court> filteredCourts = [];

  @override
  void initState() {
    super.initState();
    fetchCourts();
  }

  void fetchCourts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('courts').get();

      List<Court> courts =
          querySnapshot.docs.map((doc) => Court.fromSnapshot(doc)).toList();

      setState(() {
        allCourts = courts;
        filteredCourts =
            List.from(allCourts); // Copy allCourts to filteredCourts initially
      });
    } catch (error) {
      // Handle the error if needed
      print('Error fetching courts: $error');
    }
  }

  void filterCourts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCourts = List.from(allCourts);
      });
    } else {
      List<Court> tempFilteredCourts = allCourts
          .where((court) =>
              court.courtName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        filteredCourts = tempFilteredCourts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * .24, // Set a fixed height for the container
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: filteredCourts.length,
          itemBuilder: (context, index) {
            Court court = filteredCourts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CourtItem(
                court: court,
              ),
            );
          },
        ),
      ),
    );
  }
}
