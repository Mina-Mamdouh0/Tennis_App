import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';

// ignore: constant_identifier_names
enum ClubType { Private, Public }

class ClubTypeCubit extends Cubit<ClubType> {
  ClubTypeCubit() : super(ClubType.Private);

  void setClubType(ClubType clubType) {
    emit(clubType);
  }
}

class ClubTypeInput extends StatelessWidget {
  const ClubTypeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, left: screenWidth * .055),
            child: Text(
              S.of(context).Club_Type,
              style: TextStyle(
                color: Color(0xFF525252),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          BlocBuilder<ClubTypeCubit, ClubType>(
            builder: (context, state) {
              return Container(
                width: screenWidth * .8,
                height: screenHeight * .05,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0x300A557F)),
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
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                readOnly: true,
                                onTap: () {
                                  _showOptionsPopupMenu(context);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: screenHeight * .015),
                                  border: InputBorder.none,
                                  hintText: state.toString().split('.').last,
                                ),
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
      ),
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

    final List<ClubType> options = [ClubType.Private, ClubType.Public];

    showMenu<ClubType>(
      context: context,
      position: position,
      items: options.map((ClubType option) {
        return PopupMenuItem<ClubType>(
          value: option,
          child: Text(
            option.toString().split('.').last,
            style: const TextStyle(
              color: Color.fromARGB(255, 82, 82, 82),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        final cubit = context.read<ClubTypeCubit>();
        cubit.setClubType(value);
      }
    });
  }
}
