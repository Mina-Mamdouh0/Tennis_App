import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../generated/l10n.dart';

class ClubNamesCubit extends Cubit<List<String>> {
  ClubNamesCubit() : super([]);
  late String selectedClubId; // Add this property

  void setSelectedClubId(String clubId) {
    selectedClubId = clubId;
  }

  Future<void> fetchClubNames(String playerId) async {
    try {
      print(playerId);
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('players')
              .doc(playerId)
              .get();
      final clubIds = snapshot.data()?['clubIds'] as List<dynamic>;
      final clubNames = await fetchClubNamesFromIds(clubIds);
      emit(clubNames);
    } catch (error) {
      emit([]);
      throw Exception('Failed to fetch club names: $error');
    }
  }

  Future<List<String>> fetchClubNamesFromIds(List<dynamic> clubIds) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('clubs')
              .where(FieldPath.documentId, whereIn: clubIds)
              .get();
      final clubNames =
          snapshot.docs.map((doc) => doc.data()['clubName'] as String).toList();
      return clubNames;
    } catch (error) {
      throw Exception('Failed to fetch club names from IDs: $error');
    }
  }
}

class ClubComboBox extends StatefulWidget {
  const ClubComboBox({Key? key, required this.controller});
  final TextEditingController controller;

  @override
  _ClubComboBoxState createState() => _ClubComboBoxState();
}

class _ClubComboBoxState extends State<ClubComboBox> {
  final String playerId = FirebaseAuth.instance.currentUser!.uid;
  late final ClubNamesCubit clubNamesCubit;

  @override
  void initState() {
    super.initState();
    clubNamesCubit = ClubNamesCubit();
    clubNamesCubit.fetchClubNames(playerId);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * .83,
      child: BlocBuilder<ClubNamesCubit, List<String>>(
        bloc: clubNamesCubit,
        builder: (context, clubNames) {
          if (clubNames.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildTypeAhead(clubNames);
          }
        },
      ),
    );
  }

  Widget _buildTypeAhead(List<String> clubNames) {
    return TypeAheadFormField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 30,
            color: Colors.black,
          ),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: S.of(context).Club_name_for_hosting_the_event,
          hintStyle: const TextStyle(
            color: Color(0xFFA8A8A8),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
      suggestionsCallback: (pattern) {
        // Filter club names based on user input pattern
        return clubNames
            .where((name) => name.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (String suggestion) {
        // Handle the selected suggestion
        setState(() {
          widget.controller.text = suggestion;
        });
        context
            .read<ClubNamesCubit>()
            .setSelectedClubId(suggestion); // Add this line
      },
    );
  }

  @override
  void dispose() {
    clubNamesCubit.close();
    super.dispose();
  }
}
