import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../core/utils/widgets/court_item.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/court.dart';

class CourtSearchScreen extends StatefulWidget {
  const CourtSearchScreen({super.key});

  @override
  _CourtSearchScreenState createState() => _CourtSearchScreenState();
}

class _CourtSearchScreenState extends State<CourtSearchScreen> {
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWaveHome(
            prefixIcon: IconButton(
              onPressed: () {
                GoRouter.of(context).replace('/home');
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
            text: S.of(context).Find_Court,
            suffixIconPath: '',
          ),
          SizedBox(height: screenHeight * .03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: searchController,
                  onChanged: (value) {
                    filterCourts(value);
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).Find_Court,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * .03,
                bottom: screenHeight * .01,
                left: screenWidth * .07),
            child: Text(
              S.of(context).Courts,
              style: TextStyle(
                color: Color(0xFF313131),
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: filteredCourts.length,
              itemBuilder: (context, index) {
                Court court = filteredCourts[index];
                return Container(
                  child: CourtItem(
                    court: court,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
