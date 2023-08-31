import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../cubits/player_type_cubit.dart';

class PlayerType extends StatelessWidget {
  const PlayerType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final playerTypeCubit = context.watch<PlayerTypeCubit>();

    return Container(
      width: screenWidth * 0.8,
      height: 55,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x300D5FC3)),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * .05,
              width: screenWidth * .35,
              child: _buildPlayerTypeButton(
                context,
                S.of(context).singles,
                playerTypeCubit.state,
              ),
            ),
            Spacer(),
            SizedBox(
              height: screenHeight * .05,
              width: screenWidth * .35,
              child: _buildPlayerTypeButton(
                context,
                S.of(context).doubles,
                playerTypeCubit.state,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerTypeButton(
    BuildContext context,
    String playerType,
    String? selectedPlayerType,
  ) {
    final isSelected = selectedPlayerType == playerType;
    final playerTypeCubit = context.read<PlayerTypeCubit>();

    return GestureDetector(
      onTap: () {
        playerTypeCubit.selectPlayerType(playerType);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.035,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : null,
          borderRadius: BorderRadius.circular(50),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            playerType,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: isSelected ? 18 : 15,
              fontWeight: FontWeight.w500,
              color: isSelected ? const Color(0xFF00344E) : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
