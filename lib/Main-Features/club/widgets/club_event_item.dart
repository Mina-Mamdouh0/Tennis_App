import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/Main-Features/Featured/set_reminder/set_reminder_screen.dart';
import 'package:tennis_app/Main-Features/club/widgets/text_rich.dart';

import '../../../core/methodes/firebase_methodes.dart';
import '../../../core/methodes/global_method.dart';
import '../../../generated/l10n.dart';
import '../../../models/player.dart';
import '../../Featured/create_event/view/widgets/input_end_date.dart';
import '../../home/widgets/divider.dart';
import '../../../models/event.dart';

class ClubEventItem extends StatelessWidget {
  final Event event;
  final bool showSetReminder;

  const ClubEventItem(
      {Key? key, required this.event, required this.showSetReminder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double itemWidth = screenWidth * 0.9;
    final double imageHeight = (screenHeight + screenWidth) * 0.09;
    final double titleFontSize = (screenHeight + screenWidth) * 0.02;
    final double buttonTextFontSize = (screenHeight + screenWidth) * 0.01;
    final double buttonWidth = itemWidth * 0.4;
    final double buttonHeight = screenHeight * 0.035;
    GlobalMethod globalMethod = GlobalMethod();

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * .007),
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: 4, // Adjust the shadow elevation as desired
        shadowColor: Colors.grey, // Set the shadow color
        borderRadius: BorderRadius.circular(screenWidth * 0.079),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.051, vertical: screenHeight * 0.015),
          width: itemWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.079),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(imageHeight / 5),
                    child: Container(
                      height: imageHeight,
                      width: imageHeight,
                      child: event.photoURL != null &&
                              event.photoURL!.isNotEmpty
                          ? FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loadin.gif',
                              image: event.photoURL!,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                // Show the placeholder image on error
                                return Image.asset(
                                  'assets/images/internet.png',
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/images/profile-event.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: screenHeight * .01),
                  SizedBox(
                    height: screenHeight * .03,
                    child: SvgPicture.asset(
                      'assets/images/sun.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: screenHeight * .003),
                  Text(
                    S.of(context).sunny,
                    style: TextStyle(
                      color: const Color(0xFF00344E),
                      fontSize: screenHeight * .017,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventType,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: titleFontSize,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const MyDivider(),
                  MyTextRich(
                    text1: S.of(context).start,
                    text2: globalMethod
                        .formatDateTimeString(event.eventStartAt.toString()),
                  ),
                  SizedBox(height: screenHeight * .012),
                  MyTextRich(
                    text2: globalMethod
                        .formatDateTimeString(event.eventEndsAt.toString()),
                    text1: S.of(context).end,
                  ),
                  SizedBox(height: screenHeight * .012),
                  MyTextRich(
                    text1: S.of(context).at,
                    text2: event.eventAddress,
                  ),
                  SizedBox(height: screenHeight * .012),
                  showSetReminder // Conditionally show the "Set Reminder" button
                      ? Container(
                          width: buttonWidth,
                          height: buttonHeight,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1B262C),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(buttonHeight / 2),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              // Fetch player data and add the eventId for eventIds property
                              Method method = Method();
                              Player currentPlayer =
                                  await method.getCurrentUser();

                              if (currentPlayer.eventIds
                                  .contains(event.eventId)) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'You are already registered for this event.')),
                                );
                              } else {
                                // Add the eventId to the eventIds list
                                currentPlayer.eventIds.add(event.eventId);

                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => EndDateTimeCubit(),
                                      child: SetReminder(event: event),
                                    ),
                                  ),
                                );
                                // Update the player document in Firestore
                                await FirebaseFirestore.instance
                                    .collection('players')
                                    .doc(currentPlayer.playerId)
                                    .update(
                                        {'eventIds': currentPlayer.eventIds});
                              }
                            },
                            child: Center(
                              child: Text(
                                S.of(context).set_reminder,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: buttonTextFontSize,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
