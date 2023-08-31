import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';

enum EventType {
  InternalClubEvent,
  Party,
  InternalTeamEvent,
  FriendlyMatch,
  DailyTraining,
  PartyEvent,
  Training,
}

class EventTypeCubit extends Cubit<EventType> {
  EventTypeCubit() : super(EventType.Training);

  void setClubType(EventType clubType) {
    emit(clubType);
  }
}

class EventTypeInput extends StatelessWidget {
  EventTypeInput({Key? key}) : super(key: key);

  final Map<EventType, String> displayTexts = {
    EventType.InternalClubEvent: 'One Day',
    EventType.Party: 'Challenge',
    EventType.InternalTeamEvent: 'Competition',
    EventType.FriendlyMatch: 'Friendly Match',
    EventType.DailyTraining: 'Daily Training',
    EventType.PartyEvent: 'Party Event',
    EventType.Training: 'Training Plan',
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 2.0, left: screenWidth * .055),
          child: const Text(
            'Event Type',
            style: TextStyle(
              color: Color(0xFF525252),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        BlocBuilder<EventTypeCubit, EventType>(
          builder: (context, state) {
            return Container(
              width: screenWidth * .83,
              height: screenHeight * .057,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: .75, color: Colors.black),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                            width: 25.0), // Adjust the width as needed
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(
                              color: Color.fromARGB(255, 53, 53, 53),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            readOnly: true,
                            onTap: () {
                              _showOptionsPopupMenu(context);
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight * .015),
                              border: InputBorder.none,
                              hintText: displayTexts[state],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showOptionsPopupMenu(context);
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _showOptionsPopupMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final Map<EventType, String> displayTexts = {
      EventType.InternalClubEvent: S.of(context).One_Day,
      EventType.Party: S.of(context).Challenge,
      EventType.InternalTeamEvent: S.of(context).Competition,
      EventType.FriendlyMatch: S.of(context).Friendly_Match,
      EventType.DailyTraining: S.of(context).Daily_Training,
      EventType.PartyEvent: S.of(context).Party_Event,
      EventType.Training: S.of(context).Training_Plan,
    };

    final List<EventType> options = [
      EventType.InternalClubEvent,
      EventType.Party,
      EventType.InternalTeamEvent,
      EventType.FriendlyMatch,
      EventType.DailyTraining,
      EventType.PartyEvent,
      EventType.Training,
    ];

    showMenu<EventType>(
      context: context,
      position: position,
      items: options.map((EventType option) {
        return PopupMenuItem<EventType>(
          value: option,
          child: Text(
            displayTexts[option]!,
            style: const TextStyle(
              color: Color.fromARGB(255, 82, 82, 82),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        final cubit = context.read<EventTypeCubit>();
        cubit.setClubType(value);
      }
    });
  }
}
