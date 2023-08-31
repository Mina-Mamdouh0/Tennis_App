import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/create_club/cubit/create_club_cubit.dart';
import 'package:tennis_app/Main-Features/Featured/create_club/cubit/create_club_state.dart';
import 'package:tennis_app/Main-Features/Featured/create_club/view/widgets/Age_restriction.dart';
import 'package:tennis_app/Main-Features/Featured/create_club/view/widgets/club_type.dart';
import 'package:tennis_app/core/utils/widgets/rules_text_field.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';

import '../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../core/utils/widgets/text_field.dart';
import '../../../../generated/l10n.dart';
import '../../create_profile/widgets/profile_image.dart';

// ignore: must_be_immutable
class CreateClub extends StatelessWidget {
  CreateClub({Key? key}) : super(key: key);
  Uint8List? _selectedImageBytes;
  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController adminNameController = TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController rulesController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController courtsNumController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CreateClubCubit(context),
      child: BlocBuilder<CreateClubCubit, CreateClubState>(
        builder: (context, state) {
          if (state is CreateClubLoadingState) {
            return const Dialog.fullscreen(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CreateClubErrorState) {
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
                        text: S.of(context).Create_Club,
                        suffixIconPath: '',
                      ),
                      ProfileImage(
                        onImageSelected: (File imageFile) {
                          _selectedImageBytes = imageFile.readAsBytesSync();
                        },
                      ),
                      SizedBox(height: screenHeight * .01),
                      Text(
                        S.of(context).Set_Club_Picture,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_club_name_here,
                        text: S.of(context).Club_Name,
                        controller: clubNameController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_your_name_here,
                        text: S.of(context).Club_admin,
                        controller: adminNameController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_id_here,
                        text: S.of(context).National_Id_number,
                        controller: nationalIDController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_your_Phone_number_here,
                        text: S.of(context).Phone_number,
                        controller: phoneController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_Club_Address_here,
                        text: S.of(context).Club_Address,
                        controller: addressController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_Your_Email_here,
                        text: S.of(context).Your_Email,
                        controller: emailController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      InputTextWithHint(
                        hint: S.of(context).Type_Court_Name_here,
                        text: S.of(context).Your_Courts_Own,
                        controller: courtsNumController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      ClubTypeInput(),
                      SizedBox(height: screenHeight * .03),
                      RulesInputText(
                        header: S.of(context).Rules_and_regulations,
                        body: S
                            .of(context)
                            .Briefly_describe_your_clubs_rule_and_regulations,
                        controller: rulesController,
                      ),
                      SizedBox(height: screenHeight * .03),
                      AgeRestrictionWidget(),
                      SizedBox(height: screenHeight * .015),
                      BottomSheetContainer(
                        buttonText: S.of(context).Create,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<CreateClubCubit>().saveClubData(
                                  selectedImageBytes: _selectedImageBytes,
                                  adminNameController: adminNameController,
                                  clubNameController: clubNameController,
                                  emailController: emailController,
                                  nationalIDController: nationalIDController,
                                  phoneController: phoneController,
                                  rulesController: rulesController,
                                  addressController: addressController,
                                  courtsNumController: courtsNumController,
                                );
                          }
                        },
                      )
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
