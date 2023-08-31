import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/create_court/cubit/create_court_states.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/club_names.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/input_end_date.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/player_level.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/event_types.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';
import '../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../core/utils/widgets/input_date_and_time.dart';
import '../../../../core/utils/widgets/text_field.dart';
import '../../../../generated/l10n.dart';
import '../../create_profile/widgets/profile_image.dart';
import '../cubit/create_court_cubit.dart';

// ignore: must_be_immutable
class CreateCourt extends StatelessWidget {
  CreateCourt({Key? key}) : super(key: key);

  // Declare controllers for input fields
  final TextEditingController courtNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Uint8List? _selectedImageBytes;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventTypeCubit>(
          create: (context) => EventTypeCubit(),
        ),
        BlocProvider<EndDateTimeCubit>(
          create: (context) => EndDateTimeCubit(),
        ),
        BlocProvider(
          create: (context) => SliderCubit(),
        ),
        BlocProvider(
          create: (context) => ClubNamesCubit(),
        )
      ],
      child: BlocProvider(
        create: (context) => CreateCourtCubit(context),
        child: BlocBuilder<CreateCourtCubit, CreateCourtState>(
          builder: (context, state) {
            if (state is CreateCourtLoadingState) {
              return const Dialog.fullscreen(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is CreateCourtErrorState) {
              return Scaffold(
                body: Center(
                  child: Text(state.error),
                ),
              );
            }

            return Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppBarWaveHome(
                        prefixIcon: IconButton(
                          onPressed: () {
                            GoRouter.of(context).replace('/home');
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        text: S.of(context).Create_Court,
                        suffixIconPath: '',
                      ),
                      SizedBox(height: screenHeight * .01),
                      ProfileImage(
                        onImageSelected: (File imageFile) {
                          _selectedImageBytes = imageFile.readAsBytesSync();
                        },
                      ),
                      SizedBox(height: screenHeight * .015),
                      Text(
                        S.of(context).Set_Court_Picture,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_Court_Name_here,
                        text: S.of(context).Court_Name,
                        controller: courtNameController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_your_Phone_number_here,
                        text: S.of(context).Your_Phone,
                        controller: phoneController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputDateAndTime(
                        text: S.of(context).Start_Date_and_Time,
                        hint: S.of(context).Select_start_date_and_time,
                        onDateTimeSelected: (DateTime dateTime) {},
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputEndDateAndTime(
                        text: S.of(context).End_Date_and_time,
                        hint: S.of(context).Select_end_date_and_time,
                        onDateTimeSelected: (DateTime dateTime) {},
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_Court_Address_here,
                        text: S.of(context).Court_Address,
                        controller: addressController,
                      ),
                      SizedBox(height: screenHeight * .025),
                      BottomSheetContainer(
                        buttonText: S.of(context).Create,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<CreateCourtCubit>().saveCourtData(
                                  selectedImageBytes: _selectedImageBytes,
                                  addressController: addressController,
                                  courtNameController: courtNameController,
                                  phoneController: phoneController,
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
