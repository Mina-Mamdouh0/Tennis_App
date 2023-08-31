import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/player.dart';

class SearchInput extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  const SearchInput({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  List<Player> searchResults = [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.048,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color.fromARGB(93, 7, 32, 62),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(widget.icon, size: 20),
            const SizedBox(width: 10),
            Container(
              width: 1,
              height: screenHeight * 0.025,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: widget.controller,
                obscureText: widget.obscureText,
                onChanged: onSearchTextChanged,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFF15324F),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSearchTextChanged(String query) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('players')
        .where('playerName', isGreaterThanOrEqualTo: query)
        .where('playerName', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      searchResults =
          querySnapshot.docs.map((doc) => Player.fromSnapshot(doc)).toList();
    });
  }
}
