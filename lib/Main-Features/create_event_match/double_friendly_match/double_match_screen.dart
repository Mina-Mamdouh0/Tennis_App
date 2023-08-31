import 'package:flutter/material.dart';
import 'package:tennis_app/Main-Features/create_event_match/double_friendly_match/player_match_item.dart';

class DoubleMatchScreen extends StatelessWidget {
  const DoubleMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayerMatchItem(),
    );
  }
}
