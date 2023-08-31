import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/find_match/view/widgets/match_item.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';

import '../../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/Match.dart';
import '../../cubit/playing_screen_cubit.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({super.key, required this.match, required this.opponent});
  final FindMatch match;
  final FindMatch opponent;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final playingCubit = PlayingCubit();

    return BlocProvider(
      create: (context) => playingCubit,
      child: BlocBuilder<PlayingCubit, PlayingStatus>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: const Color(0xF8F8F8F8),
                child: Column(
                  children: [
                    AppBarWaveHome(
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
                      text: S.of(context).Find_Match,
                      suffixIconPath: '',
                    ),
                    Text(
                      S.of(context).You,
                      style: const TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * .02),
                    MatchItem(match: match),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        S.of(context).Opponent,
                        style: const TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    MatchItem(match: opponent),
                    Center(
                      // Wrap the IconButton in Center to center it horizontally
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: IconButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.change_circle_rounded,
                            size: 70,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * .02),
                    if (state == PlayingStatus.loading)
                      const CircularProgressIndicator()
                    else if (state == PlayingStatus.success)
                      Text(S.of(context).Match_data_saved_successfully)
                    else if (state == PlayingStatus.error)
                      Text(S.of(context).Error_occurred_while_saving_match_data)
                    else
                      BottomSheetContainer(
                        buttonText: S.of(context).Play,
                        onPressed: () {
                          playingCubit.fetchPlayersDataAndSaveMatchId(
                              match, opponent, context);
                        },
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
