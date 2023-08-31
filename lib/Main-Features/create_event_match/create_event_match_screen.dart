import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/create_event_match/widgets/button_match_item.dart';

import '../../core/utils/widgets/pop_app_bar.dart';
import '../../generated/l10n.dart';

class CreateEventMatchesScreen extends StatelessWidget {
  const CreateEventMatchesScreen({super.key});

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
            text: 'Create Match',
            suffixIconPath: '',
          ),
          ButtonMatchItem(
            icon: Icons.switch_access_shortcut_add_outlined,
            color: const Color(0x5172B8FF),
            text: "Single Match",
            onPressed: () {
              GoRouter.of(context).push('/singleMatches');
            },
          ),
          ButtonMatchItem(
            icon: Icons.personal_injury_outlined,
            color: const Color(0x51EE746C),
            text: "Double Match",
            onPressed: () {
              GoRouter.of(context).push('/doubleMatches');
            },
          ),
          ButtonMatchItem(
            icon: Icons.transcribe_sharp,
            color: const Color(0x8294D3D3),
            text: "Single Tournament",
            onPressed: () {
              GoRouter.of(context).push('/singleTournament');
            },
          ),
          ButtonMatchItem(
            icon: Icons.change_circle_rounded,
            color: const Color(0x51FFA372),
            text: "Double Tournament",
            onPressed: () {
              GoRouter.of(context).push('/doubleTournament');
            },
          ),
        ],
      ),
    );
  }
}
