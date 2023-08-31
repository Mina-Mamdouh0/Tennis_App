import 'package:flutter/material.dart';

import '../../../models/player.dart';

class SelectDoubleWinners extends StatefulWidget {
  final Player player1;
  final Player player2;
  final Player player3;
  final Player player4;
  final void Function(Player, Player) onWinnersSelected;

  SelectDoubleWinners({
    required this.player1,
    required this.player2,
    required this.player3,
    required this.player4,
    required this.onWinnersSelected,
  });

  @override
  _SelectDoubleWinnersState createState() => _SelectDoubleWinnersState();
}

class _SelectDoubleWinnersState extends State<SelectDoubleWinners> {
  Player? _selectedWinner1;
  Player? _selectedWinner2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.player1.playerName),
          leading: Radio(
            value: widget.player1,
            groupValue: _selectedWinner1,
            onChanged: (value) {
              setState(() {
                _selectedWinner1 = value as Player;
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.player2.playerName),
          leading: Radio(
            value: widget.player2,
            groupValue: _selectedWinner1,
            onChanged: (value) {
              setState(() {
                _selectedWinner1 = value as Player;
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.player3.playerName),
          leading: Radio(
            value: widget.player3,
            groupValue: _selectedWinner2,
            onChanged: (value) {
              setState(() {
                _selectedWinner2 = value as Player;
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.player4.playerName),
          leading: Radio(
            value: widget.player4,
            groupValue: _selectedWinner2,
            onChanged: (value) {
              setState(() {
                _selectedWinner2 = value as Player;
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_selectedWinner1 != null && _selectedWinner2 != null) {
              widget.onWinnersSelected(_selectedWinner1!, _selectedWinner2!);
            }
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
