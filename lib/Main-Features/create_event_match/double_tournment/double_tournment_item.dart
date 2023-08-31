import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/models/double_match.dart';

import '../../Featured/create_event/view/widgets/input_end_date.dart';
import '../../../core/utils/snackbar.dart';
import '../../../core/utils/widgets/input_date_and_time.dart';
import '../../../core/utils/widgets/text_field.dart';
import '../../../generated/l10n.dart';
import '../../../models/player.dart';
import '../../../models/single_match.dart';
import '../widgets/button_tournament.dart';
import '../widgets/player_info_widget.dart';

class MatchInputForm extends StatefulWidget {
  final void Function(DoubleMatch newMatch) onSave;

  MatchInputForm({super.key, required this.onSave});

  @override
  _MatchInputFormState createState() => _MatchInputFormState();
}

class _MatchInputFormState extends State<MatchInputForm> {
  String winner = '';
  var formKey = GlobalKey<FormState>();
  Player? _selectedPlayer;
  Player? _selectedPlayer2;
  Player? _selectedPlayer3;
  Player? _selectedPlayer4;
  final TextEditingController courtNameController = TextEditingController();

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

  void _onPlayerSelected3(Player player) {
    setState(() {
      _selectedPlayer3 = player;
    });
  }

  void _onPlayerSelected4(Player player) {
    setState(() {
      _selectedPlayer4 = player;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    PlayerInfoWidget(
                      selectedPlayer: _selectedPlayer,
                      onPlayerSelected: _onPlayerSelected,
                    ),
                    PlayerInfoWidget(
                      selectedPlayer: _selectedPlayer2,
                      onPlayerSelected: _onPlayerSelected2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset('assets/images/versus.png'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    PlayerInfoWidget(
                      selectedPlayer: _selectedPlayer3,
                      onPlayerSelected: _onPlayerSelected3,
                    ),
                    PlayerInfoWidget(
                      selectedPlayer: _selectedPlayer4,
                      onPlayerSelected: _onPlayerSelected4,
                    ),
                  ],
                ),
              ),
            ],
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
          InputTextWithHint(
            hint: S.of(context).Type_Court_Address_here,
            text: S.of(context).Court_Name,
            controller: courtNameController,
          ),
          SizedBox(height: screenHeight * .03),
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
          SizedBox(height: screenHeight * .015),
          ButtonTournament(
            finish: () {
              GoRouter.of(context).go('/home');
            },
            addMatch: () {
              if (formKey.currentState!.validate()) {
                _saveMatch(
                    courtNameController: courtNameController,
                    selectedPlayer: _selectedPlayer!,
                    selectedPlayer2: _selectedPlayer2!,
                    selectedPlayer3: _selectedPlayer3!,
                    selectedPlayer4: _selectedPlayer4!);
              }
              _selectedPlayer = null;
              _selectedPlayer2 = null;
              _selectedPlayer3 = null;
              _selectedPlayer4 = null;
              courtNameController.text = '';
            },
          ),
        ],
      ),
    );
  }

  void _saveMatch({
    required Player selectedPlayer,
    required Player selectedPlayer2,
    required Player selectedPlayer3,
    required Player selectedPlayer4,
    required TextEditingController courtNameController,
  }) async {
    // Check if all required data is available
    if (selectedPlayer == null || selectedPlayer2 == null) {
      // Display a message or alert to inform the user that both players need to be selected
      return showSnackBar(context, 'You Must Choose Two Players');
    }

    DateTime? selectedStartDateTime = context.read<DateTimeCubit>().state;
    DateTime? selectedEndDateTime = context.read<EndDateTimeCubit>().state;
    // Get the selected date and time from InputDateAndTime widget and convert it to DateTime object
    DateTime startTime = selectedStartDateTime;

    // Get the selected end date and time from InputEndDateAndTime widget and convert it to DateTime object
    DateTime endTime = selectedEndDateTime;

    final newMatch = DoubleMatch(
      // Don't set the match ID here since it will be auto-generated by Firestore
      player1Id: selectedPlayer.playerId,
      player2Id: selectedPlayer2.playerId,
      startTime: startTime,
      endTime: endTime,
      courtName: courtNameController.text, matchId: '',
      player3Id: selectedPlayer3.playerId,
      player4Id: selectedPlayer4.playerId, winner1: '', winner2: '',
    );

    // Call the onSave method with the newMatch object
    widget.onSave(newMatch);
    print(newMatch.matchId);
    // Call the addMatchIdToPlayer method for both selected players
  }
}
