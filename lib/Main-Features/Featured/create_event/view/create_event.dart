import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/cubit/create_event_cubit.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/input_end_date.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/invited_members.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/player_level.dart';
import 'package:tennis_app/core/utils/widgets/pop_app_bar.dart';
import 'package:tennis_app/core/utils/widgets/rules_text_field.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/event_types.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';
import '../../../../core/utils/widgets/input_date_and_time.dart';
import '../../../../core/utils/widgets/text_field.dart';
import '../../../../generated/l10n.dart';
import '../../create_profile/widgets/profile_image.dart';
import '../cubit/create_event_state.dart';

// ignore: must_be_immutable
class CreateEvent extends StatefulWidget {
  CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  // Declare controllers for input fields
  final TextEditingController eventNameController = TextEditingController();

  final TextEditingController eventAddressController = TextEditingController();

  final TextEditingController courtNameController = TextEditingController();

  final TextEditingController rulesController = TextEditingController();

  Uint8List? _selectedImageBytes;

  var formKey = GlobalKey<FormState>();
  List<String> playerIds = [];
  int? _radioValue = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventTypeCubit>(
          create: (context) => EventTypeCubit(),
        ),
        BlocProvider(
          create: (context) => SliderCubit(),
        ),
      ],
      child: BlocProvider(
        create: (context) => CreateEventCubit(context),
        child: BlocBuilder<CreateEventCubit, CreateEventState>(
          builder: (context, state) {
            if (state is CreateEventLoadingState) {
              return const Dialog.fullscreen(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is CreateEventErrorState) {
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
                        PoPAppBarWave(
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
                          text: S.of(context).Create_Event,
                          suffixIconPath: '',
                        ),
                        ProfileImage(
                          onImageSelected: (File imageFile) {
                            _selectedImageBytes = imageFile.readAsBytesSync();
                          },
                        ),
                        SizedBox(height: screenHeight * .01),
                        Text(
                          S.of(context).Set_Event_Picture,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenHeight * .03),
                        InputTextWithHint(
                          hint: S.of(context).Type_event_name_here,
                          text: S.of(context).Event_Name,
                          controller: eventNameController,
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
                        SizedBox(height: screenHeight * .03),
                        InputTextWithHint(
                          hint: S.of(context).Type_Event_address_here,
                          text: S.of(context).Event_Address,
                          controller: eventAddressController,
                        ),
                        SizedBox(height: screenHeight * .03),
                        EventTypeInput(),
                        SizedBox(height: screenHeight * .03),
                        InputTextWithHint(
                          hint: S.of(context).Type_Court_Address_here,
                          text: S.of(context).Court_Name,
                          controller: courtNameController,
                        ),
                        SizedBox(height: screenHeight * .015),
                        //Create Radio Buttons here have two items Public and custom
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _radioValue = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Public',
                                    style: TextStyle(
                                      color: Color(0xFF525252),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _radioValue = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Custom',
                                    style: TextStyle(
                                      color: Color(0xFF525252),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (_radioValue == 1)
                          Container(
                            child: MemberInvites(
                              playerIds: playerIds,
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        SizedBox(height: screenHeight * .015),
                        RulesInputText(
                          header: S.of(context).Instructions,
                          body: S
                              .of(context)
                              .Briefly_describe_your_clubs_rule_and_regulations,
                          controller: rulesController,
                        ),
                        SizedBox(height: screenHeight * .03),
                        RangeSliderWithTooltip(
                          text1: S
                              .of(context)
                              .Player_level, // Replace with your desired text for text1
                          text2: S
                              .of(context)
                              .You_can_set_a_skill_level_requirement_for_players_allowing_only_those_whose_skill_level_matches_the_requirement_you_have_set_to_participate, // Replace with your desired text for text2
                        ),
                        SizedBox(height: screenHeight * .015),
                        BottomSheetContainer(
                          buttonText: S.of(context).Create,
                          onPressed: () {
                            print("HI " + _radioValue.toString());
                            if (formKey.currentState!.validate()) {
                              context.read<CreateEventCubit>().saveEventData(
                                    context: context,
                                    selectedImageBytes: _selectedImageBytes,
                                    addressController: eventAddressController,
                                    courtNameController: courtNameController,
                                    eventNameController: eventNameController,
                                    instructionsController: rulesController,
                                    selected: playerIds,
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
      ),
    );
  }
}
