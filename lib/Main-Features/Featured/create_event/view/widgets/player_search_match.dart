import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/widgets/pop_app_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/player.dart';
import '../../../../chats/widgets/player_card.dart';

class PlayerSearchInvite extends StatefulWidget {
  final List<String> playerNames;
  final List<String> playerIds;

  const PlayerSearchInvite({
    Key? key,
    required this.playerNames,
    required this.playerIds,
  }) : super(key: key);

  @override
  _PlayerSearchInviteState createState() => _PlayerSearchInviteState();
}

class _PlayerSearchInviteState extends State<PlayerSearchInvite> {
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
              // Inside _PlayerSearchInviteState
              onTap: () {
                // Check if the name is already in the list
                if (widget.playerNames.contains(player.playerName)) {
                  // If it exists, remove it
                  setState(() {
                    widget.playerNames.remove(player.playerName);
                    widget.playerIds.remove(player.playerId);
                  });
                } else {
                  // If it doesn't exist, add it
                  setState(() {
                    widget.playerNames.add(player.playerName);
                    widget.playerIds.add(player.playerId);
                  });
                }
                Navigator.pop(context, widget.playerNames);
                print(widget.playerIds);
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
