import 'dart:io';
import 'dart:typed_data';
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
import 'create_profile_cubit/create_profile_cubit.dart';
import 'create_profile_cubit/create_profile_states.dart';

// ignore: must_be_immutable
class CreateProfile extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Uint8List? _selectedImageBytes;

  TimeOfDay? _selectedTime;

  CreateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => CreateProfileCubit(context),
      child: BlocBuilder<CreateProfileCubit, CreateProfileState>(
        builder: (context, state) {
          if (state is CreateProfileLoadingState) {
            return const Dialog.fullscreen(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CreateProfileErrorState) {
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
                        buttonText: S.of(context).create,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<CreateProfileCubit>().saveUserData(
                                  context: context,
                                  nameController: nameController,
                                  phoneNumberController: phoneNumberController,
                                  selectedImageBytes: _selectedImageBytes,
                                  selectedTime: _selectedTime,
                                );
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
}
