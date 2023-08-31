import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/chats/screens/private_chat.dart';

import '../../../core/utils/widgets/pop_app_bar.dart';
import '../../../generated/l10n.dart';
import '../../../models/player.dart';
import '../widgets/player_card.dart';

class PlayerSearchScreen extends StatefulWidget {
  @override
  _PlayerSearchScreenState createState() => _PlayerSearchScreenState();
}

class _PlayerSearchScreenState extends State<PlayerSearchScreen> {
  String _searchQuery = '';
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PoPAppBarWave(
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
            text: S.of(context).players_search,
            suffixIconPath: '',
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: S.of(context).search_players,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchQuery = '';
                    // Perform the search again with an empty query to show all players
                    _performSearch();
                  },
                ),
              ),
              onChanged: (value) {
                _searchQuery = value;
                _performSearch();
              },
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    setState(() {});
  }

  String _normalizeSearchQuery(String searchQuery) {
    // Normalize the search query to lowercase (or uppercase if preferred)
    return searchQuery.toLowerCase();
  }

  Widget _buildSearchResults() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('players').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
              child: Text('${S.of(context).error}: ${snapshot.error}'));
        }

        final players = snapshot.data!.docs;
        if (players.isEmpty) {
          return Center(child: Text(S.of(context).no_players_found));
        }

        final normalizedSearchQuery = _normalizeSearchQuery(_searchQuery);

        // Filter players based on the normalized search query
        final filteredPlayers = players.where((playerDoc) {
          final player = Player.fromSnapshot(playerDoc);
          final normalizedPlayerName = _normalizeSearchQuery(player.playerName);

          // Check if the player name contains the normalized search query
          return normalizedPlayerName.contains(normalizedSearchQuery);
        }).toList();

        if (filteredPlayers.isEmpty) {
          return Center(child: Text(S.of(context).no_matching_players_found));
        }

        return ListView.builder(
          itemCount: filteredPlayers.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final player = Player.fromSnapshot(filteredPlayers[index]);
            return GestureDetector(
              onTap: () {
                // Navigate to the PrivateChat screen when the item is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivateChat(player: player),
                  ),
                );
              },
              child: PlayerCard(
                  player: player), // Use the custom PlayerCard widget
            );
          },
        );
      },
    );
  }
}
