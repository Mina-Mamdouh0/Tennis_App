import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/roles/create_role/view/widgets/name_role.dart';
import 'package:tennis_app/Main-Features/Featured/roles/create_role/view/widgets/rights_selector.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';
import 'package:tennis_app/core/utils/widgets/pop_app_bar.dart';
import '../../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../../generated/l10n.dart';
import '../cubit/role_cubit.dart';

class CreateRole extends StatefulWidget {
  const CreateRole({Key? key}) : super(key: key);

  @override
  State<CreateRole> createState() => _CreateRoleState();
}

class _CreateRoleState extends State<CreateRole> {
  final TextEditingController roleController = TextEditingController();
  List<String> selectedWords = [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    List<String> words = [
      S.of(context).Send_Invitations,
      S.of(context).Create_Event,
      S.of(context).Create_tennis_courts,
      S.of(context).Create_offers,
      S.of(context).Edit_club,
      S.of(context).Delete_club,
      S.of(context).Edit_members,
      S.of(context).Delete_members,
      S.of(context).Create_Training,
      S.of(context).Set_up_leagues,
      S.of(context).Create_Roles,
      S.of(context).Enter_Results
    ];
    return BlocProvider(
      create: (context) => RoleCubit(),
      child: BlocConsumer<RoleCubit, RoleCreationStatus>(
        listener: (context, state) {
          if (state == RoleCreationStatus.success) {
            // Role created successfully, show the success dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Role Created'),
                content: const Text('Role has been created successfully.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();

                      // Navigate to the Roles list page
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state == RoleCreationStatus.error) {
            // Show an error toast if role creation fails
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error creating role'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state == RoleCreationStatus.loading) {
            // Show the circular progress indicator while creating the role
            return Scaffold(
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            // Show the rest of your UI when not loading
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  height: screenHeight,
                  color: const Color(0xFFF8F8F8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PoPAppBarWave(
                        prefixIcon: IconButton(
                          onPressed: () {
                            GoRouter.of(context).replace('/menu');
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        text: '   Roles',
                        suffixIconPath: '',
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Create Role',
                                style: TextStyle(
                                  color: Color(0xFF616161),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: screenHeight * .03),
                              CustomTextFormField(controller: roleController),
                              SizedBox(height: screenHeight * .05),
                              const Text(
                                'Describe Rights',
                                style: TextStyle(
                                  color: Color(0xFF616161),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Text(
                                'You can add more \nrights to a role',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF989898),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: screenHeight * .03),
                              RightSelector(
                                selectedWords: selectedWords,
                                onSelectedWordsChanged: (words) {
                                  setState(() {
                                    selectedWords = words;
                                  });
                                },
                                words: words,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: const Color(0xFFF8F8F8),
                          child: BottomSheetContainer(
                            buttonText: 'Create Role',
                            onPressed: () {
                              // Call the Cubit method to create the role
                              context.read<RoleCubit>().createRole(
                                    roleController: roleController,
                                    selectedWords: selectedWords,
                                    context: context,
                                  );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
