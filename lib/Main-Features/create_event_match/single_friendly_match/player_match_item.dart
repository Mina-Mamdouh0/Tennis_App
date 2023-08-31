import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';
import 'package:tennis_app/Main-Features/create_event_match/single_friendly_match/cubit/single_match_state.dart';
import 'package:tennis_app/Main-Features/create_event_match/widgets/player_info_widget.dart';
import '../../Featured/create_event/view/widgets/input_end_date.dart';
import '../../../core/utils/widgets/input_date_and_time.dart';
import '../../../core/utils/widgets/pop_app_bar.dart';
import '../../../core/utils/widgets/text_field.dart';
import '../../../generated/l10n.dart';
import '../../../models/player.dart';
import 'cubit/single_match_cubit.dart';

class PlayerMatchItem extends StatefulWidget {
  const PlayerMatchItem({super.key});

  @override
  State<PlayerMatchItem> createState() => _PlayerMatchItemState();
}

class _PlayerMatchItemState extends State<PlayerMatchItem> {
  Player? _selectedPlayer;
  Player? _selectedPlayer2;
  final TextEditingController courtNameController = TextEditingController();
  final TextEditingController rulesController = TextEditingController();
  void _onPlayerSelected(Player player) {
    setState(() {
      _selectedPlayer = player;
    });
  }

  void _onPlayerSelected2(Player player) {
    setState(() {
      _selectedPlayer2 = player;
    });
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocProvider(
        create: (context) => SaveMatchCubit(context),
        child: BlocBuilder<SaveMatchCubit, SaveMatchState>(
          builder: (context, state) {
            if (state is SaveMatchInProgress) {
              return const Dialog.fullscreen(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is SaveMatchFailure) {
              return Scaffold(
                body: Center(
                  child: Text(state.error),
                ),
              );
            }
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      text: 'Single Match',
                      suffixIconPath: '',
                    ),
                    SizedBox(height: screenHeight * .02),
                    const Text(
                      'Click to choose a player',
                      style: TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PlayerInfoWidget(
                            selectedPlayer: _selectedPlayer,
                            onPlayerSelected: _onPlayerSelected,
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/images/versus.png'),
                          ),
                          PlayerInfoWidget(
                            selectedPlayer: _selectedPlayer2,
                            onPlayerSelected: _onPlayerSelected2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * .02),
                    const Text(
                      'Schedule',
                      style: TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * .02),
                    InputDateAndTime(
                      text: S.of(context).Event_Start,
                      hint: S.of(context).Select_start_date_and_time,
                      onDateTimeSelected: (DateTime dateTime) {},
                    ),
                    SizedBox(height: screenHeight * .03),
                    InputEndDateAndTime(
                      text: S.of(context).Event_End,
                      hint: S.of(context).Select_end_date_and_time,
                      onDateTimeSelected: (DateTime dateTime) {},
                    ),
                    SizedBox(height: screenHeight * .03),
                    InputTextWithHint(
                      hint: S.of(context).Type_Court_Address_here,
                      text: S.of(context).Court_Name,
                      controller: courtNameController,
                    ),
                    SizedBox(height: screenHeight * .015),
                    BottomSheetContainer(
                      buttonText: 'Create',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SaveMatchCubit>().saveMatch(
                              courtNameController: courtNameController,
                              selectedPlayer: _selectedPlayer!,
                              selectedPlayer2: _selectedPlayer2!);
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
