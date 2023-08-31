import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Auth/widgets/solcial_media.dart';
import 'package:tennis_app/core/utils/snackbar.dart';

import '../../../core/utils/widgets/custom_button.dart';
import '../../../generated/l10n.dart';
import '../../cubit/auth_cubit.dart';
import '../../widgets/divider.dart';
import '../../../core/utils/widgets/input_feild.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final authCubit = context.read<AuthCubit>();

    void signUserUp() async {
      await authCubit.signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context);
    }

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthErrorState) {
          showSnackBar(context, state.error); // Displaying the error message
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * .022,
                        ),
                        Text(
                          S.of(context).create_basic_profile,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * .022,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * .05, vertical: 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).email,
                              style: const TextStyle(
                                color: Color(0xFF797979),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        MyInputText(
                          controller: emailController,
                          hintText: S.of(context).email_address,
                          icon: Icons.email_outlined,
                          obscureText: false,
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * .05, vertical: 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).password,
                              style: const TextStyle(
                                color: Color(0xFF797979),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        MyInputText(
                          hintText: S.of(context).password,
                          icon: Icons.lock_open_outlined,
                          obscureText: true,
                          controller: passwordController,
                        ),
                        //or continue with
                        const MyDivider(),
                        const SocialMedia(),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push('/forgetPassword');
                          },
                          child: Text(
                            S.of(context).forgot_password,
                            style: const TextStyle(
                              color: Color(0xFF1B262C),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BottomSheetContainer(
                  buttonText: S.of(context).sign_up,
                  onPressed: () {
                    signUserUp();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
