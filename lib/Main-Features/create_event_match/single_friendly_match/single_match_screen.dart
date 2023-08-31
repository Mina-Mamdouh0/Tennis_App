import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Featured/create_event/view/widgets/input_end_date.dart';
import 'player_match_item.dart';

class SingleMatchScreen extends StatelessWidget {
  const SingleMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayerMatchItem(),
    );
  }
}
