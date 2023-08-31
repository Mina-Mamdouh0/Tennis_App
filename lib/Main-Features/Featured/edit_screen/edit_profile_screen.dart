import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Main-Features/Featured/create_profile/widgets/app_bar_wave.dart';
import 'package:tennis_app/Main-Features/Featured/create_profile/widgets/gender_selection.dart';
import 'package:tennis_app/Main-Features/Featured/create_profile/widgets/input_time.dart';
import 'package:tennis_app/Main-Features/Featured/create_profile/widgets/player_type.dart';
import 'package:tennis_app/Main-Features/Featured/create_profile/widgets/profile_image.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/input_date.dart';
import '../../../core/utils/widgets/text_field.dart';
import '../../../generated/l10n.dart';
import '../../../models/player.dart';
import 'edit_profile_cubit.dart';
import 'edit_profile_states.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Uint8List? _selectedImageBytes;

  TimeOfDay? _selectedTime;

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => EditProfileCubit(context),
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          if (state is EditProfileLoadingState) {
            return const Dialog.fullscreen(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is EditProfileErrorState) {
            return Scaffold(
              body: Center(
                child: Text(state.error),
              ),
            );
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: const Color(0xFFF8F8F8),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // App bar
                      const AppBarWave(),
                      //Profile image
                      ProfileImage(
                        onImageSelected: (File imageFile) {
                          _selectedImageBytes = imageFile.readAsBytesSync();
                        },
                      ),
                      SizedBox(height: screenHeight * .01),
                      Text(
                        S.of(context).setProfilePicture,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * .03),
                      const GenderSelection(),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).typeYourName,
                        text: S.of(context).playerName,
                        controller: nameController,
                      ),
                      SizedBox(height: screenHeight * .025),
                      InputTextWithHint(
                        hint: S.of(context).typeYourPhoneNumber,
                        text: S.of(context).phoneNumber,
                        controller: phoneNumberController,
                      ),
                      SizedBox(height: screenHeight * .025),
                      InputDate(
                        hint: S.of(context).Select_Date_of_Birth,
                        text: S.of(context).Your_Age,
                        onDateTimeSelected: (DateTime dateTime) {
                          // Handle date selection
                        },
                      ),
                      SizedBox(height: screenHeight * .025),
                      InputTimeField(
                        hint: S.of(context).typeYourPreferredPlayingTime,
                        text: S.of(context).preferredPlayingTime,
                        onTimeSelected: (TimeOfDay? time) {
                          _selectedTime = time;
                        },
                      ),
                      SizedBox(height: screenHeight * .025),
                      const PlayerType(),
                      SizedBox(height: screenHeight * .01),
                      BottomSheetContainer(
                        buttonText: S.of(context).Update_Player,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final currentUser = await getCurrentUser();

                            context.read<EditProfileCubit>().saveUserData(
                                context: context,
                                nameController: nameController,
                                phoneNumberController: phoneNumberController,
                                selectedImageBytes: _selectedImageBytes,
                                selectedTime: _selectedTime,
                                currentPlayer: currentUser);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<Player> getCurrentUser() async {
    // Get the current user from Firebase Authentication
    final String playerId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('players')
        .doc(playerId)
        .get();

    return Player.fromSnapshot(snapshot);
  }
}
